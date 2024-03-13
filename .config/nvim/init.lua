vim.g.base46_cache = vim.fn.stdpath("data") .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")

-- load plugins
require("lazy").setup({
	{
		"NvChad/NvChad",
		lazy = false,
		branch = "v2.5",
		import = "nvchad.plugins",
		config = function()
			require("options")
		end,
	},

	{ import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require("nvchad.autocmds")

vim.schedule(function()
	require("mappings")
end)

-- customized settings
local autocmd = vim.api.nvim_create_autocmd
autocmd("FileType", {
	pattern = "go",
	callback = function()
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
		-- skip formatting for ruby files
		if vim.bo.filetype == "ruby" then
			return
		end
		require("conform").format({ bufnr = args.buf })
	end,
})

-- vim command autocomplete
local opt = vim.opt
opt.wildmode = { "list", "longest" }
opt.wildoptions = "fuzzy"
