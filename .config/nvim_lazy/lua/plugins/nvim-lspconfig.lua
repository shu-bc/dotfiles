return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      gopls = {
        settings = {
          gopls = {
            hints = {
              assignVariableTypes = false,
              parameterNames = false,
            },
            gofumpt = false,
            staticcheck = false,
          },
        },
      },
    },
  },
}
