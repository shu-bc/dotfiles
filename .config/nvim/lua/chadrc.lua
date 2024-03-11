local M = {}

local highlights = require("highlights")

M.ui = {
	theme = "tokyonight",

	hl_override = highlights.override,
	hl_add = highlights.add,
}

return M
