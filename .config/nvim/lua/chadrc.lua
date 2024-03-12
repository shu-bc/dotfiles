local M = {}

local highlights = require("highlights")

M.ui = {
	theme = "solarized_osaka",

	hl_override = highlights.override,
	hl_add = highlights.add,
}

return M
