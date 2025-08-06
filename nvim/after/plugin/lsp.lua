local lspconfig = require("lspconfig")
local cmp = require("cmp")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- Navigation commands
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- Go to definition
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- Go to declaration
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- Go to implementation
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- Find references
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts) -- Go to type definition

	-- Documentation
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- Show hover info
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts) -- Show signature help

	-- Code actions
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Code actions
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Rename symbol
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, opts) -- Format code

	-- Diagnostics
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- Previous diagnostic
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- Next diagnostic
	vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts) -- Show diagnostic
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts) -- List diagnostics
end

---- LSPs
-- Lua
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
		},
	},
})

-- Rust
lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- C/C++
lspconfig.clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Bash
lspconfig.bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Python
lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

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

---- Formatting & Linting
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.black,
	},
})

-- Auto format on save
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = { "*.lua", "*.rs", "*.c", "*.cpp", "*.py", "*.sh" },
--     callback = function() vim.lsp.buf.format() end
-- })
