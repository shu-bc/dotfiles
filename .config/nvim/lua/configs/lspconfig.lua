local configs = require("nvchad.configs.lspconfig")

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = require("lspconfig")
local servers = {
	"html",
	"cssls",
	"tsserver",
	"clangd",
	"gopls",
	"solargraph",
	"terraformls",
	"pylsp",
	"bufls",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_init = on_init,
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- golangcilsp
if not configs.golangcilsp then
	configs.golangcilsp = {
		default_config = {
			cmd = { "golangci-lint-langserver" },
			root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
			init_options = {
				command = { "golangci-lint", "run", "--out-format", "json", "--issues-exit-code=1" },
			},
		},
	}
end
lspconfig.golangci_lint_ls.setup({
	filetypes = { "go", "gomod" },
})

--
-- lspconfig.pyright.setup { blabla}
