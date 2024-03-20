return {
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup({
				gofmt = "gofmt",
				-- GoDebug does not work well
				dap_debug = false,
			})
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
	},

	{
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		opts = {
			auto_preview = false,
		},
		event = "LspAttach",
	},
}
