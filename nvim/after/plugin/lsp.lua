local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local lsp_zero = require('lsp-zero')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
lsp_zero.default_setup({
    capabilities = capabilities
})

-- Setup cmp
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp_action.tab_complete(),
        ['<S-Tab>'] = cmp_action.select_prev_or_fallback,
    }),
    sources = {
        { name = "nvim_lsp" }, -- LSP completions
        { name = "luasnip" },
        { name = "path" },     -- Filepath completions
        { name = "buffer" },   -- Buffer completions
        { name = "nvim_lua" },
    },
})

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

-- Mason
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'emmylua_ls', 'rust_analyzer' },
    handlers = {
        lsp_zero.default_setup,
    }
})

-- auto format
-- rust
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.rs",
    callback = function()
        vim.lsp.buf.format({ async = false })
    end
})
