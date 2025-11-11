local ignored = { bufls = true, ["buf_ls"] = true } -- 両表記に対応
local orig = vim.lsp.handlers["textDocument/publishDiagnostics"]

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, conf)
  local client = ctx and ctx.client_id and vim.lsp.get_client_by_id(ctx.client_id)
  if client and ignored[client.name] then
    return -- bufls からの diagnostics だけ無視
  end
  return orig(err, result, ctx, conf)
end
