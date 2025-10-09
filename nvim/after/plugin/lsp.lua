local cmp = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup('lsp_attach_keymaps', { clear = true }),
	callback = function(args)
		local bufnr = args.buf
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
		-- vim.keymap.set("n", "<leader>f", function()
		-- 	vim.lsp.buf.format({ async = true })
		-- end, opts) -- Format code
		
		-- Diagnostics
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- Previous diagnostic
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- Next diagnostic
		vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts) -- Show diagnostic
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts) -- List diagnostics
	end,
	desc = 'LSP: Set up keymaps',
})

---- LSPs
-- Lua
vim.lsp.config('lua_ls', {
	cmd = { 'lua-language-server' },
	root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
	filetypes = { 'lua' },
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
		},
	},
})
vim.lsp.enable('lua_ls')

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
vim.lsp.config('clangd', {
	cmd = { 'clangd' },
	root_markers = { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git' },
	filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
	capabilities = capabilities,
})
vim.lsp.enable('clangd')

-- Bash
vim.lsp.config('bashls', {
	cmd = { 'bash-language-server', 'start' },
	root_markers = { '.git' },
	filetypes = { 'sh' },
	capabilities = capabilities,
})
vim.lsp.enable('bashls')

-- Python
vim.lsp.config('ty', {})
vim.lsp.enable('ty')

vim.lsp.config('ruff', {
	cmd = { 'ruff', 'server' },
	root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
	filetypes = { 'python' },
	capabilities = capabilities,
})
vim.lsp.enable('ruff')

vim.lsp.config('pyright', {
	cmd = { 'pyright-langserver', '--stdio' },
	root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json', '.git' },
	filetypes = { 'python' },
	capabilities = capabilities,
	settings = {
		pyright = {
			disableOrganizeImports = true,
		},
		python = {
			analysis = {
				ignore = { '*' },
			},
		},
	},
})
vim.lsp.enable('pyright')

-- Disable Ruff hover
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end
		if client.name == 'ruff' then
			client.server_capabilities.hoverProvider = false
		end
	end,
	desc = 'LSP: Disable hover capability from Ruff',
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
