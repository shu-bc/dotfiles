return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = require("configs.overrides").treesitter,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		config = function()
			require("configs.treesitter-textobjects")
		end,
	},
}
