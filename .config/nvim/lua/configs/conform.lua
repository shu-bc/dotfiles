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

    go = { "goimports", "gofmt" },
    proto = { "buf" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 5000,
    lsp_format = "fallback",
  },
}

require("conform").setup(options)
