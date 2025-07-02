return {
  "folke/snacks.nvim",
  lazy = false, -- Or true if you want it to be lazy-loaded
  opts = {
    picker = {
      formatters = {
        file = {
          filename_first = true,
          truncate = 60,
        },
      },
      layouts = {
        default = {
          layout = {
            width = 0.9,
            height = 0.9,
          },
        },
      },
      win = {
        preview = {
          wo = {
            number = false,
            relativenumber = false,
          },
        },
      },
    },
  },
}
