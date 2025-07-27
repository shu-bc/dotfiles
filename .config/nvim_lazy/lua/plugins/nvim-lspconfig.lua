return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      gopls = {
        settings = {
          gopls = {
            hints = false,
            gofumpt = false,
            staticcheck = false,
            usePlaceholders = false,
            codelenses = {
              test = true,
            },
          },
        },
      },
    },
  },
}
