vim.lsp.enable({
	"lua_ls",
	"tinymist",
	"nixd",
	"clangd",
	"bashls",
	"ruff",
	"pyright",
	"haskell-language-server",
	"tofu_ls",
})

-- language specific fixes
--- multi-file tinymist and typst preview
local tinymist_main = nil

vim.lsp.config("tinymist", {
	on_attach = function(client, bufnr)
		local root = vim.fs.root(bufnr, { "main.typ", ".git", "typst.toml" })
		if root then
			local main = root .. "/main.typ"
			if vim.uv.fs_stat(main) then
				tinymist_main = main
				client:exec_cmd({
					title = "pin",
					command = "tinymist.pinMain",
					arguments = { main },
				}, { bufnr = bufnr })
			end
		end

		vim.keymap.set("n", "<leader>tp", function()
			local main = vim.api.nvim_buf_get_name(0)
			tinymist_main = main
			client:exec_cmd({
				title = "pin",
				command = "tinymist.pinMain",
				arguments = { main },
			}, { bufnr = bufnr })
		end, { desc = "[T]inymist [P]in", noremap = true })

		vim.keymap.set("n", "<leader>tu", function()
			tinymist_main = nil
			client:exec_cmd({
				title = "unpin",
				command = "tinymist.pinMain",
				arguments = { vim.v.null },
			}, { bufnr = bufnr })
		end, { desc = "[T]inymist [U]npin", noremap = true })
	end,
})

require("typst-preview").setup({
	get_main_file = function(path)
		return tinymist_main or path
	end,
})

--- fix vim missing in lua
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})

--- disable ruff hover
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

--- enable wrapping on texty documents
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.tex", "*.bib", "*.typ", "*.md" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
	end,
})

--- vimtex
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_compiler_latexmk = {
	build_method = "latexmk",
	options = { "-pdf", "-bibtex", "-interaction=nonstopmode", "-shell-escape" },
}
vim.g.vimtex_view_method = "mupdf"

-- completion
require("blink.cmp").setup({
	keymap = { preset = "enter" },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
	signature = { enabled = true },
})

-- formatting
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		sh = { "shfmt" },
		rust = { "rustfmt" },
		nix = { "alejandra" },
		typst = { "typstyle" },
		haskell = { "ormulu" },
	},
	format_on_save = {
		timeout_ms = 1000,
		lsp_fallback = true,
	},
})

-- highlighting
-- workaround for nixos
local parser_path = vim.fn.stdpath("data") .. "site/parser"
vim.opt.runtimepath:append(parser_path)
---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
	parser_install_dir = parser_path,
	ensure_installed = {
		"c",
		"cpp",
		"rust",
		"lua",
		"typst",
		"nix",
		"bash",
		"python",
	},
	auto_install = false,
	highlight = { enable = true },
})
