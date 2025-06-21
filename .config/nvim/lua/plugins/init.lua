local overrides = require "configs.overrides"

return {
  {
    "stevearc/conform.nvim",
    config = function()
      require "configs.conform"
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
      require "configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "folke/which-key.nvim",
  },

  {
    "windwp/nvim-autopairs",
    enable = false,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = {
      completion = {
        completeopt = "menu,menuone,noseleqqct",
      },
      preselect = "cmp.PreselectMode.None",
    },
  },

  -- Install a plugin
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, conf)
      require("telescope").load_extension "fzf"
      conf.defaults = {
        mappings = {
          i = { ["<c-f>"] = require("telescope.actions").to_fuzzy_refine },
        },
        path_display = { "filename_first" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
        },
      }

      return conf
    end,
    -- config = function()
    --   require("telescope").load_extension "fzf"
    --   require("telescope").setup {
    --     defaults = {
    --       mappings = {
    --         i = { ["<c-f>"] = require("telescope.actions").to_fuzzy_refine },
    --       },
    --       path_display = { "truncate" },
    --       -- layout_config = {
    --       --   prompt_position = "top",
    --       -- },
    --     },
    --   }
    -- end,
  },

  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  {
    "tomasky/bookmarks.nvim",
  },

  {
    "ruifm/gitlinker.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("gitlinker").setup()
    end,
    lazy = false,
  },
}
