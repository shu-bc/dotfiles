return {
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_no_tab_map = true

			local keymap = vim.keymap.set
			-- https://github.com/orgs/community/discussions/29817#discussioncomment-4217615
			keymap(
				"i",
				"<C-g>",
				'copilot#Accept("<CR>")',
				{ silent = true, expr = true, script = true, replace_keycodes = false }
			)
		end,
		lazy = false,
	},
}
