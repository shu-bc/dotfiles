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
    -- setup = {
    --   gopls = function(_, opts)
    --     opts.cmd = { "gopls", "--remote=auto", "--logfile=auto", "-debug=:0", "-remote.debug=:0", "-rpc.trace" }
    --   end,
    -- },
  },
}
