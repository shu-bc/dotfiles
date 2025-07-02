local claude_buf = nil

local function update_claude_buffer()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local buf_type = vim.bo[buf].buftype
    if buf_type == "terminal" then
      claude_buf = buf
      break
    end
  end
end

local function get_claude_buffer()
  if claude_buf and vim.api.nvim_buf_is_valid(claude_buf) then
    return claude_buf
  end
  update_claude_buffer()
  return claude_buf
end

local function send_file_to_claude()
  local relative_path = vim.fn.expand("%:.")

  local claude_buffer = get_claude_buffer()

  -- 常にクリップボードにyank
  vim.fn.setreg("+", relative_path)

  if claude_buffer then
    -- ターミナルバッファに送信
    local chan = vim.api.nvim_buf_get_var(claude_buffer, "terminal_job_id")
    vim.api.nvim_chan_send(chan, "@" .. relative_path)
    print("Written to Claude and yanked: " .. relative_path)

    -- Claude Codeウィンドウをアクティブにする
    local claude_win = vim.fn.bufwinid(claude_buffer)
    if claude_win ~= -1 then
      vim.api.nvim_set_current_win(claude_win)
    end
  else
    print("Yanked: " .. relative_path)
  end
end

local function send_selection_to_claude()
  -- 選択開始とカーソル位置
  local s_line = vim.fn.line("v")
  local e_line = vim.fn.line(".")

  -- 逆順で選ばれている可能性に備えてソート
  if s_line > e_line then
    s_line, e_line = e_line, s_line
  end

  -- 相対パス + 行範囲を組み立て
  local path = vim.fn.expand("%:.")
  local text = string.format("%s:%d-%d", path, s_line, e_line)

  local claude_buffer = get_claude_buffer()

  -- 常にクリップボードにyank
  vim.fn.setreg("+", text)

  if claude_buffer then
    -- ターミナルバッファに送信
    local chan = vim.api.nvim_buf_get_var(claude_buffer, "terminal_job_id")
    vim.api.nvim_chan_send(chan, "@" .. text)
    print("Written to Claude and yanked: " .. text)

    -- Visual modeを抜けてからClaude Codeウィンドウをアクティブにする
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
    vim.schedule(function()
      local claude_win = vim.fn.bufwinid(claude_buffer)
      if claude_win ~= -1 then
        vim.api.nvim_set_current_win(claude_win)
      end
    end)
  else
    print("Yanked: " .. text)
    -- Visual modeを抜ける
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  end
end

return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
  config = function()
    require("claude-code").setup({
      window = {
        split_ratio = 0.4, -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
        position = "vertical", -- Position of the window: "botright", "topleft", "vertical", "rightbelow vsplit", etc.
        enter_insert = true, -- Whether to enter insert mode when opening Claude Code
        hide_numbers = true, -- Hide line numbers in the terminal window
        hide_signcolumn = true, -- Hide the sign column in the terminal window
      },
    })
  end,
  keys = {
    {
      "<leader>Ca",
      send_file_to_claude,
      desc = "Add context to Claude Code",
    },
    {
      "<leader>Ca",
      send_selection_to_claude,
      mode = "x",
      desc = "Add context to Claude Code",
    },
  },
  init = function()
    -- Set up autocommand to update buffer reference when terminal is created
    vim.api.nvim_create_autocmd("TermOpen", {
      callback = function()
        vim.schedule(function()
          update_claude_buffer()
          local buf = get_claude_buffer()
          if buf then
            vim.bo[buf].buflisted = false
          end
        end)
      end,
    })
  end,
  lazy = false,
}
