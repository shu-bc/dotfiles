local options = {
	lsp_fallback = true,

	formatters = {
		goimports = {
			prepend_args = { "-local", "github.com/knowledge-work" },
		},
	},

	formatters_by_ft = {
		lua = { "stylua" },

		javascript = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },

		sh = { "shfmt" },

		-- go = { "gofmt", "goimports" },
		go = { "goimports", "gofmt" },
	},

	-- format_on_save = {
	-- 	-- These options will be passed to conform.format()
	-- 	timeout_ms = 2000,
	-- 	lsp_format = "fallback",
	-- },
}

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		if vim.bo.filetype ~= "ruby" then
			return
		end
		require("conform").format({
			bufnr = args.buf,
			timeout_ms = 2000,
			async = true,
		})
	end,
})

require("conform").setup(options)
