local utils = require("config.utils")
local key = utils.key
local k_opt = utils.k_opt

vim.lsp.enable("clangd")
vim.lsp.enable("ruff")
vim.lsp.enable("pyright")

vim.diagnostic.enable = true

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        key('n', 'grn', vim.lsp.buf.rename, k_opt('LSP: Rename symbol', true, true, args.buf))
        key('n', 'gra', vim.lsp.buf.code_action, k_opt('LSP: Code actions', true, true, args.buf))
        key('n', 'grr', vim.lsp.buf.references, k_opt('LSP: References', true, true, args.buf))
        key('n', 'gri', vim.lsp.buf.implementation, k_opt('LSP: Implementation', true, true, args.buf))
        key('n', 'gO', vim.lsp.buf.document_symbol, k_opt('LSP: Document symbols', true, true, args.buf))
        key('n', 'gD', vim.lsp.buf.declaration, k_opt('LSP: Declaration', true, true, args.buf))
        key('n', 'gd', vim.lsp.buf.definition, k_opt('LSP: Defintion', true, true, args.buf))
        key('n', 'gl', vim.diagnostic.open_float, k_opt('LSP: Diagnostics', true, true, args.buf))
        key('i', '<c-s>', vim.lsp.buf.signature_help, k_opt('LSP: Signature help', true, true, args.buf))
        key('n', 'K', vim.lsp.buf.hover, k_opt('LSP: Hover', true, true, args.buf))
        key('n', 'g[', vim.diagnostic.goto_prev, k_opt('LSP: Diagnostics previous', true, true, args.buf))
        key('n', 'g]', vim.diagnostic.goto_next, k_opt('LSP: Diagnostics next', true, true, args.buf))
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

vim.o.statusline = table.concat({
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
