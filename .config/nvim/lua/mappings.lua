require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- conform.nvim
map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "File Format with conform" })

map("n", "<leader>tr", "<cmd>TroubleToggle<CR>", { desc = "TroubleToggle" })
map("n", "<leader>gg", ":LazyGit <CR>", { desc = "LazyGit" })

-- indenting
map("v", ">", ">gv", { desc = "Indent" })

-- Telescope
map("n", "<leader>fs", "<cmd> Telescope lsp_dynamic_workspace_symbols <CR>", { desc = "Find workspace symbols" })
map("n", "<leader>fl", "<cmd> Telescope aerial <CR>", { desc = "Outline of current buf" })
map("n", "<leader>wd", "<cmd> Telescope diagnostics <CR>", { desc = "Workspace diagnostics" })
map("v", "<leader>fw", "<cmd> Telescope grep_string <CR>", { desc = "Find word under cursor" })
map("n", "<leader>fc", function()
  require("telescope.builtin").command_history()
end, { desc = "Telescope command history" })

-- Telescope LSP functions
map("v", "<leader>fs", function()
  require("telescope.builtin").lsp_workspace_symbols { query = vim.fn.expand "<cword>" }
end, { desc = "Find symbol under cursor" })

map("n", "gi", function()
  require("telescope.builtin").lsp_implementations { show_line = false }
end, { desc = "Telescope lsp implementations" })

map("n", "<leader>gr", function()
  require("telescope.builtin").lsp_references { show_line = false }
end, { desc = "Telescope lsp reference" })

-- Octo
map(
  "n",
  "<leader>gp",
  "<cmd> Octo search is:pr is:open review-requested:shu-bc <CR>",
  { desc = "List Github Review Quested Pull Request" }
)

-- new terminals
map("n", "<leader>h", function()
  require("nvchad.term").toggle { pos = "sp", size = 0.4 }
end, { desc = "Terminal New horizontal term" })

map("n", "<leader>v", function()
  require("nvchad.term").toggle { pos = "vsp", size = 0.4 }
end, { desc = "Terminal New vertical window" })

-- toggleable
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm", size = 0.4 }
end, { desc = "Terminal Toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm", size = 0.4 }
end, { desc = "Terminal New horizontal term" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Terminal Toggle Floating term" })

map("t", "<ESC><ESC>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })

-- Luasnip
local ls = require "luasnip"
vim.keymap.set({ "i", "s" }, "<C-e>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

-- GoTest
map("n", "<leader>tf", "<cmd>GoTestFunc<CR>", { desc = "GoTestFunc" })

-- GoImport
map("n", "<leader>gi", "<cmd>GoImports<CR>", { desc = "GoImports" })

-- For Claude Code --

-- Write relative path to Claude window
map("n", "<leader>ca", function()
  local relative_path = vim.fn.expand "%:."

  -- Claude Codeウィンドウを探す（ターミナルバッファを検索）
  local claude_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local buf_type = vim.bo[buf].buftype
    if buf_type == "terminal" then
      claude_buf = buf
      break
    end
  end

  -- 常にクリップボードにyank
  vim.fn.setreg("+", relative_path)

  if claude_buf then
    -- ターミナルバッファに送信
    local chan = vim.api.nvim_buf_get_var(claude_buf, "terminal_job_id")
    vim.api.nvim_chan_send(chan, "@" .. relative_path)
    print("Written to Claude and yanked: " .. relative_path)

    -- Claude Codeウィンドウをアクティブにする
    local claude_win = vim.fn.bufwinid(claude_buf)
    if claude_win ~= -1 then
      vim.api.nvim_set_current_win(claude_win)
    end
  else
    print("Yanked: " .. relative_path)
  end
end, { desc = "Add context to Claude Code" })

vim.keymap.set("x", "<leader>ca", function()
  -- 選択開始とカーソル位置
  local s_line = vim.fn.line "v"
  local e_line = vim.fn.line "."

  -- 逆順で選ばれている可能性に備えてソート
  if s_line > e_line then
    s_line, e_line = e_line, s_line
  end

  -- 相対パス + 行範囲を組み立て
  local path = vim.fn.expand "%:."
  local text = string.format("%s:%d-%d", path, s_line, e_line)

  -- Claude Codeウィンドウを探す（ターミナルバッファを検索）
  local claude_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local buf_type = vim.bo[buf].buftype
    if buf_type == "terminal" then
      claude_buf = buf
      break
    end
  end

  -- 常にクリップボードにyank
  vim.fn.setreg("+", text)

  if claude_buf then
    -- ターミナルバッファに送信
    local chan = vim.api.nvim_buf_get_var(claude_buf, "terminal_job_id")
    vim.api.nvim_chan_send(chan, "@" .. text)
    print("Written to Claude and yanked: " .. text)

    -- Visual modeを抜けてからClaude Codeウィンドウをアクティブにする
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
    vim.schedule(function()
      local claude_win = vim.fn.bufwinid(claude_buf)
      if claude_win ~= -1 then
        vim.api.nvim_set_current_win(claude_win)
      end
    end)
  else
    print("Yanked: " .. text)
    -- Visual modeを抜ける
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  end
end, { desc = "Add context to Claude Code" })
