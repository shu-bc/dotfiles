local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node

ls.add_snippets("go", {
	s(
		"cont",
		c(1, {
			t("context.Context"),
			t("context.Background()"),
		})
	),
})
