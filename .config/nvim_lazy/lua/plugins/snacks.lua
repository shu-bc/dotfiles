return {
  "folke/snacks.nvim",
  lazy = false, -- Or true if you want it to be lazy-loaded
  opts = {
    picker = {
      -- general picker settings
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
      -- config picker sources
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
        -- config files picker
        files = {
          matcher = {
            frecency = true,
          },
        },
        explorer = {
          layout = {
            layout = {
              width = 50,
            },
          },
          actions = {
            ---@param picker snacks.Picker
            broaden_list = function(picker, item)
              local win = picker.list.win.win
              if not win then
                return
              end
              local w = vim.api.nvim_win_get_width(win)
              vim.api.nvim_win_set_width(win, math.floor(w + 10))
            end,
          },
          win = {
            list = {
              keys = {
                [">>"] = { "broaden_list", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
}
