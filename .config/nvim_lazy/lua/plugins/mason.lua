return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "stylua",
      "shfmt",

      -- go
      "gopls",
      "goimports",
      -- "golangci-lint-langserver",

      -- terraform
      "terraform-ls",

      -- json
      "json-lsp",

      -- -- protobuf
      -- "buf",
    },
  },
}
