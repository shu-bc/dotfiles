require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
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
map("v", "<leader>fs", function()
  require("telescope.builtin").lsp_workspace_symbols { query = vim.fn.expand "<cword>" }
end, { desc = "Find symbol under cursor" })

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

-- Aerial
map("n", "<leader>at", "<cmd>AerialToggle!<CR>", { desc = "Aerial Toggle" })

map("n", "<leader>o", "i<CR><ESC>", { desc = "Insert newline below" })

-- Luasnip
local ls = require "luasnip"
vim.keymap.set({ "i", "s" }, "<C-e>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

-- GoTest
map("n", "<leader>tf", "<cmd>GoTestFunc<CR>", { desc = "GoTestFunc" })

-- leader g i -> GoImport
map("n", "<leader>gi", "<cmd>GoImports<CR>", { desc = "GoImports" })

-- Yank relative path
map("n", "<leader>yr", function()
  local relative_path = vim.fn.expand "%:."
  vim.fn.setreg("+", relative_path)
  print("Yanked: " .. relative_path)
end, { desc = "Yank relative path" })

-- Yank relative path with line numbers in visual mode
map("v", "<leader>yr", function()
  local relative_path = vim.fn.expand "%:."
  local start_line = vim.fn.line "'<"
  local end_line = vim.fn.line "'>"
  local path_with_lines = relative_path .. ":" .. start_line .. "-" .. end_line
  vim.fn.setreg("+", path_with_lines)
  print("Yanked: " .. path_with_lines)
end, { desc = "Yank relative path with line numbers" })
