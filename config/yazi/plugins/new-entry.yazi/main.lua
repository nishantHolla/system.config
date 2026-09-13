local M = {}
local u = require(".utils")

local create_dir = function(dir)
    local dir_url = Url(dir)
    if not dir_url then
        return nil, "Invalid Url"
    end

    local ok, err = fs.create("dir_all", dir_url)

    if not ok then
        return nil, tostring(err)
    end

    return dir_url
end

local create_file = function(file)
    local file_url = Url(file)
    if not file_url then
        return nil, "Invalid Url"
    end

    local parent = file_url.parent
    if parent then
        local p_url, err = create_dir(parent)
        if err then
            return nil, err
        end
    end

    local fd, err = fs.access():write(true):create_new(true):open(file_url)
    if not fd then
        return nil, tostring(err)
    end

    return file_url
end

M.entry = function(self, job)
    --- Prompt for files and folders to create
    local arg_str, event = u.prompt("New entry: ")

    if event ~= 1 or arg_str == "" then
        return
    end

    --- Parse input to get all the files/folders to create
    local args = u.split_str_by_space(arg_str)

    --- Create entries
    local url, err = nil, nil

    for i, arg in ipairs(args) do
        if string.sub(arg, -1) == "/" then
            url, err = create_dir(arg)
            if err then
                u.error("new-entry: Failed to create directory " .. arg, err)
                return
            end
        else
            url, err = create_file(arg)
            if err then
                u.error("new-entry: Failed to create file " .. arg, err)
                return
            end
        end
    end

    --- Focus last entry
    if not err then
        local last_entry = args[#args]
        ya.emit("reveal", { Url(last_entry) })
    end
end

return M
