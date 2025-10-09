local cmp = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

---- LSPs
-- Lua
vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        "stylua.toml",
        "selene.toml",
        "selene.yml",
        ".git",
    },
    filetypes = { "lua" },
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
        },
    },
})
vim.lsp.enable("lua_ls")

-- Rust
-- done by rustaceanvim
-- vim.lsp.config('rust_analyzer', {
-- 	cmd = { 'rust-analyzer' },
-- 	root_markers = { 'Cargo.toml', 'rust-project.json' },
-- 	filetypes = { 'rust' },
-- 	capabilities = capabilities,
-- })
-- vim.lsp.enable('rust_analyzer')

-- C/C++
vim.lsp.config("clangd", {
    cmd = { "clangd" },
    root_markers = {
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        "configure.ac",
        ".git",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    capabilities = capabilities,
})
vim.lsp.enable("clangd")

-- Bash
vim.lsp.config("bashls", {
    cmd = { "bash-language-server", "start" },
    root_markers = { ".git" },
    filetypes = { "sh" },
    capabilities = capabilities,
})
vim.lsp.enable("bashls")

-- Python
vim.lsp.config("ty", {})
vim.lsp.enable("ty")

vim.lsp.config("ruff", {
    cmd = { "ruff", "server" },
    root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
    filetypes = { "python" },
    capabilities = capabilities,
})
vim.lsp.enable("ruff")

vim.lsp.config("pyright", {
    cmd = { "pyright-langserver", "--stdio" },
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
        ".git",
    },
    filetypes = { "python" },
    capabilities = capabilities,
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                ignore = { "*" },
            },
        },
    },
})
vim.lsp.enable("pyright")

-- Disable Ruff hover
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then
            return
        end
        if client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
        end
    end,
    desc = "LSP: Disable hover capability from Ruff",
})

-- Formatters
require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        sh = { "shfmt" },
        rust = { "rustfmt" },
    },
    format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
    },
})

-- Format on leader f (using conform)
vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format" })

---- Completion
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
    },
})
