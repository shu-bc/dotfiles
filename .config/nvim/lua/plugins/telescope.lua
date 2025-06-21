return {
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
            preview_width = 0.45,
            width = 0.95,
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
}
