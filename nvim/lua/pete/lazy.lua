local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.opt.termguicolors = true
vim.g.mapleader = " "
-- because lean asked me to
vim.g.maplocalleader = ";"

require("lazy").setup({
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
	},
	{
		"cbochs/grapple.nvim",
		opts = {
			scope = "git",
			icons = true,
			status = true,
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>a", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
			{ "<C-e>", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },

			{ "<C-h>", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
			{ "<C-j>", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
			{ "<C-k>", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
			{ "<C-l>", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },
		},
	},
	{ "mbbill/undotree" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "stevearc/conform.nvim" },
	{ "pechorin/any-jump.vim" },
	{ "nvim-lualine/lualine.nvim", opts = {} },
	{ "folke/which-key.nvim" },
	{ "numToStr/Comment.nvim", opts = {} },
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
	},
	-- {
	-- 	"windwp/nvim-autopairs",
	-- 	event = "InsertEnter",
	-- 	opts = {},
	-- },
	{
		"kylechui/nvim-surround",
		version = "*",
		opts = {},
	},
	{ "tadmccorkle/markdown.nvim", opts = {} },
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		opts = {},
	},
	{ "lervag/vimtex" },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{ "stevearc/dressing.nvim" },
	{
		"ziontee113/icon-picker.nvim",
		config = function()
			require("icon-picker").setup({
				disable_legacy_commands = true,
			})
		end,
	},
	{
		"chomosuke/typst-preview.nvim",
		lazy = false,
		version = "1.*",
		opts = {},
	},
	-- { "RaafatTurki/hex.nvim", opts = {} },
	{
		"stevearc/oil.nvim",
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		opts = {
			view_options = {
				show_hidden = true,
			},
			buf_options = {
				buflisted = false,
				bufhidden = "hide",
			},
			keymaps = {
				["<CR>"] = "actions.select",
				["<C-t>"] = { "actions.select", opts = { tab = true } },
				["<C-p>"] = "actions.preview",
				["<C-c>"] = { "actions.close", mode = "n" },
				["<C-l>"] = "actions.refresh",
				["-"] = { "actions.parent", mode = "n" },
				["_"] = { "actions.open_cwd", mode = "n" },
				["`"] = { "actions.cd", mode = "n" },
				["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
				["gs"] = { "actions.change_sort", mode = "n" },
				["gx"] = "actions.open_external",
				["g."] = { "actions.toggle_hidden", mode = "n" },
				["g\\"] = { "actions.toggle_trash", mode = "n" },
			},
			use_default_keymaps = false,
		},
		lazy = false,
	},
	{
		url = "https://codeberg.org/andyg/leap.nvim",
	},
	{ "tpope/vim-sleuth" },
	{
		"lukas-reineke/indent-blankline.nvim",
		version = "*",
		opts = {
			scope = { enabled = false },
			indent = { char = "┊" },
		},
		main = "ibl",
	},
	{ "hiphish/rainbow-delimiters.nvim" },
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
		opts = {
			open_mapping = "<C-\\>",
			-- fix for weird 8-column verticals
			size = function(term)
				if term.direction == "horizontal" then
					return 20
				elseif term.direction == "vertical" then
					return 80
				end
			end,
		},
	},
	{ "lewis6991/gitsigns.nvim", opts = {} },
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			require("onedark").setup({
				transparent = true,
			})
			require("onedark").load()

			-- Fix harpoon tab bar
			vim.api.nvim_set_hl(0, "HarpoonInactive", { fg = "#abb2bf", bg = "NONE" })
			vim.api.nvim_set_hl(0, "HarpoonActive", { fg = "#abb2bf", bg = "#484c54", bold = true })
			vim.api.nvim_set_hl(0, "HarpoonNumberActive", { fg = "#abb2bf", bg = "#484c54", bold = true })
			vim.api.nvim_set_hl(0, "HarpoonNumberInactive", { fg = "#abb2bf", bg = "NONE" })
		end,
	},
}, {
	lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json",
})
