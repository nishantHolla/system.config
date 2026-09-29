local M = {}

M.error = function(title, content, timeout)
    ya.notify({
        title=title,
        content=content,
        timeout=timeout or 5.0,
        level="error"
    })
end

M.info = function(title, content, timeout)
    ya.notify({
        title=title,
        content=content,
        timeout=timeout or 5.0,
        level="info"
    })
end

M.prompt = function(prompt_text)
    return ya.input({
        pos = {"top-center", y = 0, w = 80},
        title = prompt_text,
        value = "",
        obscure = false,
        realtime = false,
        debounce = 0.3
    })
end

M.sync_run = function(cmd)
    local permit = ui.hide()

    local output, err = Command("sh")
        :arg("-c")
        :arg(cmd)
        :stdin(Command.INHERIT)
        :stdout(Command.PIPED)
        :stderr(Command.PIPED)
        :output()

    permit:drop()
    return output, err
end

M.split_str_by_space = function(str)
    local result = {}

    for word in string.gmatch(str, "%S+") do
        table.insert(result, word)
    end

    return result
end

M.get_hovered = ya.sync(function(state)
    return cx.active.current.hovered
end)

M.get_selected = ya.sync(function(state)
	local s = cx.active.selected
	local selected = {}

	for a, b in pairs(s) do
		table.insert(selected, b.url)
	end

	return selected
end)

M.get_cwd = ya.sync(function(state)
    return cx.active.current.cwd
end)

M.get_stem = function(str)
    return string.match(str, "^([^.]+)")
end

M.str_ends_with = function(str, suffix)
    return suffix == "" or string.sub(str, -string.len(suffix)) == suffix
end

M.not_in = function(str, table)
    for i, j in ipairs(table) do
        if str == j then
            return false
        end
    end

    return true
end

M.trim_str = function(s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

return M
