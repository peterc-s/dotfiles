local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
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
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    { 'navarasu/onedark.nvim' },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },

    { 'nvim-treesitter/playground' },

    { 'ThePrimeagen/harpoon' },

    { 'mbbill/undotree' },

    { 'tpope/vim-fugitive' },

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- Uncomment the two plugins below if you want to manage the language servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'L3MON4D3/LuaSnip' },
        }
    },

    { 'nvim-lualine/lualine.nvim' },

    { 'folke/which-key.nvim' },

    { 'numToStr/Comment.nvim' },

    { 'simrat39/rust-tools.nvim' },

    { 'm4xshen/autoclose.nvim' },

    {
        'kylechui/nvim-surround',
        version = '*'
    },

    { 'tikhomirov/vim-glsl' },

    { 'tadmccorkle/markdown.nvim' },

    { 'lervag/vimtex' },

    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require("colorizer").setup()
        end,
    },

    {
        "giusgad/pets.nvim",
        dependencies = {
            "giusgad/hologram.nvim",
            "MunifTanjim/nui.nvim",
        }
    },

    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp"
    },

    { "stevearc/dressing.nvim" },

    {
        "ziontee113/icon-picker.nvim",
        config = function()
            require("icon-picker").setup({
                disable_legacy_commands = true
            })
        end,
    },

    {
        'Julian/lean.nvim',
        ft = 'lean',
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require('lean').setup({
                mappings = true,
            })
        end,
    },

    {
        'chomosuke/typst-preview.nvim',
        lazy = false,
        version = '1.*',
        opts = {},
    }
})
