local overrides = require("configs.overrides")

return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("configs.conform")
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			git = { enable = true },
		},
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},

	{
		"folke/which-key.nvim",
		-- enabled = false,
	},

	-- Install a plugin
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_no_tab_map = true

			local keymap = vim.keymap.set
			-- https://github.com/orgs/community/discussions/29817#discussioncomment-4217615
			keymap(
				"i",
				"<C-g>",
				'copilot#Accept("<CR>")',
				{ silent = true, expr = true, script = true, replace_keycodes = false }
			)
		end,
		lazy = false,
	},

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

	{
		"nvim-telescope/telescope.nvim",
		opts = {
			defaults = {
				mappings = {
					i = { ["<c-f>"] = require("telescope.actions").to_fuzzy_refine },
				},
			},
		},
	},

	{
		"windwp/nvim-autopairs",
		opts = {
			fast_wrap = {
				map = "<C-p>",
			},
		},
	},

	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	{
		"pwntester/octo.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			-- OR 'ibhagwan/fzf-lua',
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("octo").setup()
		end,
		lazy = false,
	},

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
			require("aerial").setup({})
		end,
		event = "LspAttach",
	},

	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
}