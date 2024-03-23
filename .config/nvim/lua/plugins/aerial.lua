return {
	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope.nvim",
		},

		config = function()
			require("telescope").load_extension("aerial")
			require("aerial").setup({
				layout = {
					max_width = { 60, 0.4 },
				},
			})
		end,
		event = "LspAttach",
	},
}
