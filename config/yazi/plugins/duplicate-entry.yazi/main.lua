local M = {}
local u = require(".utils")

local MAX_LIMIT = 100

local make_unique_entry = function(url)
	local parent = url.parent
	if not parent then
		return nil, "Parent not found"
	end

	local stem = url.stem
	if not stem then
		return nil, "Stem not found"
	end

	local extension = url.ext

	for i = 1, MAX_LIMIT do
		local new_name = stem .. "_" .. tostring(i)
		if extension then
			new_name = new_name .. "." .. extension
		end

		local new_url = parent:join(new_name)

		if not fs.cha(new_url) then
			os.execute("cp -r " .. tostring(url) .. " " .. tostring(new_url))
			return new_url
		end
	end

	return nil, "Max limit reached"
end

local make_unique_file = function(url)
end

M.entry = function(self, job)
	--- Get the hovered entry
	local hovered = u.get_hovered()

	if not hovered then
		return
	end

	--- Duplicate the entry
	local url, err = make_unique_entry(hovered.url)

	if err then
		u.error("duplicate-entrty: Failed to duplicate entry", tostring(err))
	end
end

return M
