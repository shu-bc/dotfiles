---@type MappingsTable
local M = {}

M.general = {
	n = {
		-- [";"] = { ":", "enter command mode", opts = { nowait = true } },

		-- format with conform
		["<leader>fm"] = {
			function()
				require("conform").format()
			end,
			"formatting",
		},

		["<leader>tr"] = { "<cmd>TroubleToggle<CR>", "TroubleToggle" },
		["<leader>gg"] = { ":LazyGit <CR>" },
	},
	v = {
		[">"] = { ">gv", "indent" },
	},
}

M.telescope = {
	plugin = true,

	n = {
		-- find
		["<leader>fs"] = { "<cmd> Telescope lsp_dynamic_workspace_symbols <CR>", "find workspace symbols" },
		["<leader>fl"] = { "<cmd> Telescope aerial <CR>", "Outline of current buf" },
		["<leader>wd"] = { "<cmd> Telescope diagnostics <CR>", "workspace diagnostics" },
	},
}

-- more keybinds!

return M
