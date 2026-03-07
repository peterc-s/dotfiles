local map = vim.keymap.set

--- vim config
map("n", "<leader>o", ":update<CR> :source<CR>")

--- files
map("n", "<leader>q", ":quit<CR>")

--- LSP binds
map("n", "<leader>lf", function()
	require("conform").format({
		timeout_ms = 1000,
		lsp_fallback = true,
	})
end)
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach_keymaps", { clear = true }),
	callback = function(args)
		local bufnr = args.buf
		local opts = { noremap = true, silent = true, buffer = bufnr }

		-- Navigation commands
		map("n", "gd", vim.lsp.buf.definition, opts) -- Go to definition
		map("n", "gD", vim.lsp.buf.declaration, opts) -- Go to declaration
		map("n", "gi", vim.lsp.buf.implementation, opts) -- Go to implementation
		map("n", "gr", vim.lsp.buf.references, opts) -- Find references
		map("n", "gt", vim.lsp.buf.type_definition, opts) -- Go to type definition

		-- Documentation
		map("n", "K", vim.lsp.buf.hover, opts) -- Show hover info

		-- Code actions
		map("n", "<leader>la", vim.lsp.buf.code_action, opts) -- Code actions
		map("n", "<leader>lr", vim.lsp.buf.rename, opts) -- Rename symbol

		-- Diagnostics
		map("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts) -- Previous diagnostic
		map("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts) -- Previous diagnostic
		map("n", "gl", vim.diagnostic.open_float, opts) -- Show diagnostic
		map("n", "<leader>q", vim.diagnostic.setloclist, opts) -- List diagnostics
	end,
})

--- system clipboard
map({ "n", "v", "x" }, "<leader>y", '"+y')
map("n", "<leader>Y", '"+Y')
map({ "n", "v", "x" }, "<leader>d", '"+d')
map("n", "<leader>D", '"+D')

-- plugin binds
--- mini.pick
map("n", "<leader>f", ":Pick files<CR>")
map("n", "<leader>r", ":Pick grep_live<CR>")
map("n", "<leader>h", ":Pick help<CR>")
map("n", "<leader>v", function()
	vim.cmd.vsplit()
	vim.cmd.wincmd("l")
	require("mini.pick").builtin.files()
end)

--- oil.nvim
map("n", "<leader>e", ":Oil<CR>")

--- grapple.nvim
map("n", "<leader>a", ":Grapple toggle<CR>")
map("n", "<C-e>", ":Grapple toggle_tags<CR>")
map("n", "<C-h>", ":Grapple select index=1<CR>")
map("n", "<C-j>", ":Grapple select index=2<CR>")
map("n", "<C-k>", ":Grapple select index=3<CR>")
map("n", "<C-l>", ":Grapple select index=4<CR>")

--- leap.nvim
map({ "n", "x", "o" }, "s", "<Plug>(leap)")
map("n", "S", "<Plug>(leap-from-window)")
