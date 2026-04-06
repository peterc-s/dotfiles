local gh = function(x)
	return "https://github.com/" .. x
end
local cb = function(x)
	return "https://codeberg.org/" .. x
end

vim.pack.add({
	cb("andyg/leap.nvim"),
	gh("MeanderingProgrammer/render-markdown.nvim"),
	gh("cbochs/grapple.nvim"),
	gh("chomosuke/typst-preview.nvim"),
	gh("echasnovski/mini.pick"),
	gh("hiphish/rainbow-delimiters.nvim"),
	gh("jbyuki/venn.nvim"),
	gh("kylechui/nvim-surround"),
	gh("lervag/vimtex"),
	gh("lewis6991/gitsigns.nvim"),
	gh("lukas-reineke/indent-blankline.nvim"),
	gh("mluders/comfy-line-numbers.nvim"),
	gh("mrcjkb/rustaceanvim"),
	gh("navarasu/onedark.nvim"),
	gh("neovim/nvim-lspconfig"),
	gh("norcalli/nvim-colorizer.lua"),
	gh("pechorin/any-jump.vim"),
	gh("rafamadriz/friendly-snippets"),
	gh("saghen/blink.cmp"),
	gh("stevearc/conform.nvim"),
	gh("stevearc/dressing.nvim"),
	gh("stevearc/oil.nvim"),
	gh("tadmccorkle/markdown.nvim"),
	gh("tpope/vim-abolish"),
	{ src = gh("nvim-treesitter/nvim-treesitter"), version = "master" }, -- probably swap to main once treesitter v0.26.1 is available on nixpkgs
})

-- configure
require("mini.pick").setup()

require("onedark").setup({
	transparent = true,
})

require("oil").setup({
	view_options = {
		show_hidden = true,
	},
	buf_options = {
		buflisted = false,
		bufhidden = "hide",
	},
	use_default_keymaps = false,
	keymaps = {
		["<CR>"] = "actions.select", -- open file / enter dir
		["<C-v>"] = "actions.select_vsplit", -- open in vsplit (optional)
		["<C-s>"] = "actions.select_split", -- open in split (optional)
		["<C-t>"] = "actions.select_tab", -- open in new tab (optional)
		["q"] = "actions.close", -- quit oil
		["-"] = "actions.parent", -- go up
		["g."] = "actions.toggle_hidden", -- toggle dotfiles
		["gr"] = "actions.refresh", -- refresh listing
	},
})

require("grapple").setup({
	scope = "cwd",
	icons = false,
	status = false,
})

require("ibl").setup({
	scope = { enabled = false },
	indent = { char = "┊" },
})

require("comfy-line-numbers").setup({
	hidden_buffer_types = { "terminal", "nofile" },
})
