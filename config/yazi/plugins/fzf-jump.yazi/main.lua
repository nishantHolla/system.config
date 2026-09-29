local M = {}
local u = require(".utils")

local usage = function()
    u.error("fzf-jump: Invalid usage", "Usage fzf-jump : [current | home] [all | file | dir]")
end

M.entry = function(self, job)
    if #job.args ~= 2 then
        usage()
        return
    end

    local target = job.args[1]
    if u.not_in(target, {"current", "home"}) then
        usage()
        return
    end

    local mode = job.args[2]
    if u.not_in(mode, {"all", "file", "dir"}) then
        usage()
        return
    end

    local target_val = ""
    if target == "current" then
        target_val = "."
    elseif target == "home" then
        target_val = os.getenv("HOME")
    end

    local mode_val = ""
    if mode == "all" then
        mode_val = ""
    elseif mode == "file" then
        mode_val = "-t f"
    elseif mode == "dir" then
        mode_val = "-t d"
    end

    local cmd = string.format("fd . %s %s | fzf", target_val, mode_val)

    local output, err = u.sync_run(cmd)
    if err then
        u.error("fzf-jump: Failed to run command", tostring(err))
        return
    end

    local selected = u.trim_str(output.stdout)
    if #selected == 0 then
        return
    end

    local cha, err = fs.cha(Url(selected))
    if err then
        u.error("Failed to get cha", tostring(err))
    end

    if cha.is_dir then
        ya.emit("cd", { selected })
    else
        ya.emit("reveal", { selected })
    end
end

return M
