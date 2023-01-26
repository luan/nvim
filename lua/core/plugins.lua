local function config(opts)
	local mod = 'config.' .. opts.name:gsub("%..*", "")
	local m = require(mod)
	if type(m) == "table" then
		m.setup()
	end
end

local function tableize(spec)
	if type(spec) == "string" then
		spec = { spec }
	end
	return spec
end

local M = {}

M.c = function(spec)
	spec = tableize(spec)
	spec["config"] = config
	return spec
end

return M

