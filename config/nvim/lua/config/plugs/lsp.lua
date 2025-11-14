vim.lsp.enable('clangd')
vim.lsp.enable('ruff')
vim.lsp.enable('gopls')

vim.diagnostic.enable = true

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
})


vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    Key('n', 'grn', vim.lsp.buf.rename, K_Opt('LSP: Rename symbol', true, true, args.buf))
    Key('n', 'gra', vim.lsp.buf.code_action, K_Opt('LSP: Code actions', true, true, args.buf))
    Key('n', 'grr', vim.lsp.buf.references, K_Opt('LSP: References', true, true, args.buf))
    Key('n', 'gri', vim.lsp.buf.implementation, K_Opt('LSP: Implementation', true, true, args.buf))
    Key('n', 'gO', vim.lsp.buf.document_symbol, K_Opt('LSP: Document symbols', true, true, args.buf))
    Key('n', 'gD', vim.lsp.buf.declaration, K_Opt('LSP: Declaration', true, true, args.buf))
    Key('n', 'gl', vim.diagnostic.open_float, K_Opt('LSP: Diagnostics', true, true, args.buf))
    Key('i', '<c-s>', vim.lsp.buf.signature_help, K_Opt('LSP: Signature help', true, true, args.buf))
    Key('n', 'K', vim.lsp.buf.hover, K_Opt('LSP: Hover', true, true, args.buf))
    Key('n', 'g[', vim.diagnostic.goto_prev, K_Opt('LSP: Diagnostics previous', true, true, args.buf))
    Key('n', 'g]', vim.diagnostic.goto_next, K_Opt('LSP: Diagnostics next', true, true, args.buf))
  end
})

function _G.lsp_diagnostics_counts()
  local diagnostics = vim.diagnostic.get(0)
  local counts = { error = 0, warn = 0, info = 0, hint = 0 }

  for _, diag in ipairs(diagnostics) do
    if diag.severity == vim.diagnostic.severity.ERROR then
      counts.error = counts.error + 1
    elseif diag.severity == vim.diagnostic.severity.WARN then
      counts.warn = counts.warn + 1
    elseif diag.severity == vim.diagnostic.severity.INFO then
      counts.info = counts.info + 1
    elseif diag.severity == vim.diagnostic.severity.HINT then
      counts.hint = counts.hint + 1
    end
  end

  return string.format('E:%d W:%d I:%d H:%d', counts.error, counts.warn, counts.info, counts.hint)
end

vim.o.signcolumn = 'yes:1'

vim.o.statusline = table.concat({
  '%f',                                -- file path
  '%h%m%r',                            -- flags
  ' %{&ff}',                           -- file format
  ' %{&fileencoding}',                 -- encoding
  ' %=',                               -- alignment
  '%{v:lua.lsp_diagnostics_counts()}', -- LSP diagnostic
  ' %=',                               -- alignment
  ' %l,%c',                            -- line and column
  ' %p%%'                              -- percentage
})


vim.api.nvim_create_autocmd({ 'DiagnosticChanged' }, {
  callback = function()
    vim.cmd('redrawstatus')
  end,
})

