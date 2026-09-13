local M = {}
local u = require(".utils")

local make_archive = function()
	local selected = u.get_selected()
	if #selected == 0 then return end

	local selected_str = ""
	for i, sel in ipairs(selected) do
		selected_str = selected_str .. " " .. tostring(sel)
	end

	local dest, ret = u.prompt("Archive name: ")
	if ret == 0 then
		return nil, "Failed to get input"
	elseif ret == 2 then
		return nil, nil
	end

	local dest_url = u.get_cwd():join(dest)

	if u.str_ends_with(dest, ".zip") or u.str_ends_with(dest, ".7z") then
		local c = Command("7z"):arg("a"):arg(tostring(dest_url))
		for i, sel in ipairs(selected) do
			c:arg(tostring(sel))
		end

		local status, err = c:status()
	end

end

local extract_archive = function()
	local hovered = u.get_hovered()
	if not hovered then
		return nil, nil
	end

	local cha = fs.cha(hovered.url)
	if not cha then
		return nil, "Cha not found"
	end

	if cha.is_dir then
		return nil, "Can not extrach directory"
	end

	local parent = hovered.url.parent
	if not parent then
		return nil, "Parent not found"
	end

	local stem = u.get_stem(hovered.url.name)
	if not stem then
		return nil, "Stem not found"
	end

	local dest, ret = u.prompt("Extract to [leave empty to use archive name]: ")
	if ret == 0 then
		return nil, "Failed to get user input"
	elseif ret == 2 then
		return nil, nil
	end
	if dest == "" then dest = stem end

	local src_url = hovered.url
	local dest_url = parent:join(dest)

	local dest_cha = fs.cha(dest_url)
	if dest_cha then
		return nil, "Destination " .. tostring(dest_url) .. " already exists"
	end

	local status, err

	if src_url:ends_with(".tar.gz") or src_url:ends_with(".tgz") then
		status, err = Command("tar")
			:arg("-xzf")
			:arg(tostring(src_url))
			:arg("-C")
			:arg(tostring(dest_url))
			:status()
	elseif src_url:ends_with(".tar.bz2") then
		status, err = Command("tar")
			:arg("-xjf")
			:arg(tostring(src_url))
			:arg("-C")
			:arg(tostring(dest_url))
			:status()
	elseif src_url:ends_with(".tar.xz") then
		status, err = Command("tar")
			:arg("-xJf")
			:arg(tostring(src_url))
			:arg("-C")
			:arg(tostring(dest_url))
			:status()
	else
		status, err = Command("7z")
			:arg("x")
			:arg(tostring(src_url))
			:arg("-o" .. tostring(dest_url))
			:status()
	end

	return dest_url
end

M.entry = function(self, job)
	if #job.args ~= 1 then
		u.error("manage-archive: Invalid usage", "Usage: manage-archive make | archive")
		return
	end

	if job.args[1] == "extract" then
		local url, err = extract_archive()
		if err then
			u.error("manage-archive: Failed to extract", err)
		end

	elseif job.args[1] == "make" then
		local url, err = make_archive()
		if err then
			u.error("manage-archive: Failed to make", err)
		end

	else
		u.error("manage-archive: Invalid usage", "Usage: manage-archive make | archive")
		return
	end
end

return M
