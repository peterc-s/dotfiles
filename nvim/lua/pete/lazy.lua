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
    { "nvim-treesitter/playground" },
    {
        "ThePrimeagen/harpoon",
        dependencies = { "nvim-lua/plenary.nvim" },
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
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        opts = {},
    },
    { "tikhomirov/vim-glsl" },
    { "tadmccorkle/markdown.nvim", opts = {} },
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
    -- Waiting for lspconfig dependency to be resolved
    -- {
    --     "Julian/lean.nvim",
    --     ft = "lean",
    --     dependencies = {
    --         "neovim/nvim-lspconfig",
    --         "nvim-lua/plenary.nvim",
    --     },
    --     config = function()
    --         require("lean").setup({
    --             mappings = true,
    --         })
    --     end,
    -- },
    {
        "chomosuke/typst-preview.nvim",
        lazy = false,
        version = "1.*",
        opts = {
            dependencies_bin = {
                ["tinymist"] = "/run/current-system/sw/bin/tinymist"  
                ["websocat"] = "/run/current-system/sw/bin/websocat"  
            },
        },
    },
    { "RaafatTurki/hex.nvim", opts = {} },
    {
        "stevearc/oil.nvim",
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        opts = {
            view_options = {
                show_hidden = true,
            },
        },
        lazy = false,
    },
    { "ggandor/leap.nvim" },
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
