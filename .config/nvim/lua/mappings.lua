require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })

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

-- Octo
map(
	"n",
	"<leader>gp",
	"<cmd> Octo search is:pr is:open review-requested:shu-bc <CR>",
	{ desc = "List Github Review Quested Pull Request" }
)

-- new terminals
map("n", "<leader>h", function()
	require("nvchad.term").toggle({ pos = "sp", size = 0.4 })
end, { desc = "Terminal New horizontal term" })

map("n", "<leader>v", function()
	require("nvchad.term").toggle({ pos = "vsp", size = 0.4 })
end, { desc = "Terminal New vertical window" })

-- toggleable
map({ "n", "t" }, "<A-v>", function()
	require("nvchad.term").toggle({ pos = "vsp", id = "vtoggleTerm", size = 0.4 })
end, { desc = "Terminal Toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
	require("nvchad.term").toggle({ pos = "sp", id = "htoggleTerm", size = 0.4 })
end, { desc = "Terminal New horizontal term" })

map({ "n", "t" }, "<A-i>", function()
	require("nvchad.term").toggle({ pos = "float", id = "floatTerm" })
end, { desc = "Terminal Toggle Floating term" })

vim.keymap.del("t", "<ESC>")

-- Aerial
map("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Aerial Toggle" })

-- Paste without yanking
map("v", "p", '"_dP', { desc = "Paste without yanking" })
