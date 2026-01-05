return {
  "mfussenegger/nvim-lint",
  opts = {
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      go = { "golangcilint" },
    },
    linters = {
      golangcilint = {
        -- パッケージ単位で実行するため、ファイル名引数を渡さない
        args = {
          "run",
          "--output.json.path",
          "stdout",
          "--show-stats=false",
          "--issues-exit-code=0",
          function()
            return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
          end,
        },
      },
    },
  },
}
