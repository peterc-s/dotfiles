local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- LaTeX Snippets
ls.add_snippets("tex", {
    s("\\figure", {
        t("\\begin{figure}"),
        t({ "", "    \\centering" }),
        t({ "", "    \\caption{" }), i(1, ""), t("}"),
        t({ "", "    \\label{" }), i(2, "fig:"), t("}"),
        t({ "", "\\end{figure}" }),
        i(0),
    }),
})

-- Setup cmp
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp_action.select_prev_or_fallback,
  }),
  snippet = {
      expand = function(args)
          ls.lsp_expand(args.body)
      end,
  },
  sources = {
      { name = "luasnip" },
      { name = "nvim_lsp" }, -- LSP completions
      { name = "buffer" }, -- Buffer completions
      { name = "path" }, -- Filepath completions
  },
})

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup({'rust_analyzer'})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    lsp_zero.default_setup,
  },
})

require('lspconfig').lua_ls.setup({})

-- auto format
vim.api.nvim_create_augroup("AutoFormat", {})

vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = "*.rs",
        group = "AutoFormat",
        callback = function()
            vim.cmd("silent !cargo fmt")
            vim.cmd("silent !cargo clippy --fix --allow-dirty")
            vim.cmd("edit")
        end,
    }
)
