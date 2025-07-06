-- Snacks.picker()
return {
  "folke/snacks.nvim",
  lazy = false, -- Or true if you want it to be lazy-loaded
  opts = {
    picker = {
      formatters = {
        file = {
          filename_first = true,
          truncate = 80,
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
            number = true,
            relativenumber = false,
            wrap = true,
          },
        },
      },
      sources = {
        -- config notifcations picker
        notifications = {
          actions = {
            send = function(picker, item)
              -- Create a temporary buffer
              local buf = vim.api.nvim_create_buf(false, true)

              -- Split window horizontally with 30% height
              vim.cmd("botright split")
              vim.api.nvim_win_set_height(0, math.floor(vim.o.lines * 0.3))

              -- Set window wrap for long lines
              vim.wo.wrap = true

              -- Set the buffer in the new window
              vim.api.nvim_win_set_buf(0, buf)

              -- Copy item.preview.text to the buffer
              if item.preview and item.preview.text then
                local lines = vim.split(item.preview.text, "\n")
                vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
              end
            end,
          },
          win = {
            input = {
              keys = {
                ["<CR>"] = { "send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
}
