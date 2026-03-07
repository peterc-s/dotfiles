vim.g.mapleader = " " -- leader early

-- modules
require("config.plugins")
require("config.binds")
require("config.visuals")
require("config.lsp")

-- options
vim.o.swapfile = false
vim.o.ignorecase = true
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.scrolloff = 8
vim.o.splitright = true
vim.o.splitbelow = false

--- numbering
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"

--- formatting
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.opt.runtimepath:append(vim.fn.stdpath("config") .. "/config")
