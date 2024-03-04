-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
-- editor default config

local autocmd = vim.api.nvim_create_autocmd
autocmd("FileType", {
  pattern = "go",
  callback = function ()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.smartindent = true
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})

autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

-- vim command autocomplete
local opt = vim.opt
opt.wildmode = {"list", "longest"}
opt.wildoptions = "fuzzy"
