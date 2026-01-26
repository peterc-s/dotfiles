local cmp = require("cmp")
local luasnip = require("luasnip")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

---- LSPs

-- TypeScript & JavaScript
vim.lsp.config("tsserver", {
	cmd = { "typescript-language-server", "--stdio" },
	root_markers = { "tsconfig.json", "jsconfig.json", ".git" },
	filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
	capabilities = capabilities,
	settings = {
		documentFormatting = true,
	},
})
vim.lsp.enable("tsserver")

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

-- Nix
vim.lsp.config("nixd", {
	cmd = { "nixd" },
	root_markers = {
		"flake.nix",
		".git",
	},
	filetypes = {"nix"},
	capabilities = capabilities,
})
vim.lsp.enable("nixd")

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
-- vim.lsp.config("ty", {
--     cmd = { "ty", "server" },
--     root_markers = { "pyproject.toml", ".git" },
--     filetypes = { "python" },
--     capabilities = capabilities,
-- })
-- vim.lsp.enable("ty")

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
	},
})
vim.lsp.enable("pyright")

-- typst
vim.lsp.config("tinymist", {
	cmd = { "tinymist" },
	root_markers = {
		"main.typ",
		"lib.typ",
	},
	filetypes = { "typst" },
	capabilities = capabilities,
	settings = {
		formatterMode = "typstyle",
		-- semanticTokens = "disable",
		lint = { enabled = true, when = "onSave" },
	},
})
vim.lsp.enable("tinymist")

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
		nix = { "alejandra" },
		typst = { "tinymist" },
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

-- Completion
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if luasnip.expandable() then
					luasnip.expand()
				else
					cmp.confirm({
						select = true,
					})
				end
			else
				fallback()
			end
		end),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.locally_jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
})

-- Needed for extra snippets
require("luasnip.loaders.from_vscode").lazy_load()
