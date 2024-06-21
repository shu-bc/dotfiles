local options = {
	lsp_fallback = true,

	formatters_by_ft = {
		lua = { "stylua" },

		javascript = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },

		sh = { "shfmt" },

		go = { "gofmt", "goimports" },
	},

	-- format_on_save = {
	-- 	-- These options will be passed to conform.format()
	-- 	timeout_ms = 500,
	-- 	lsp_fallback = true,
	-- },
}

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		if vim.bo.filetype ~= "ruby" then
			return
		end
		require("conform").format({ bufnr = args.buf })
	end,
})

require("conform").setup(options)
