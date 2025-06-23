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
      require("aerial").setup {
        layout = {
          max_width = { 60, 0.4 },
        },
      }
      require("telescope").setup {
        extensions = {
          aerial = {
            -- Available modes: symbols, lines, both
            show_columns = "lines",
          },
        },
      }
      require("telescope").load_extension "aerial"
    end,
    event = "LspAttach",
  },
}
