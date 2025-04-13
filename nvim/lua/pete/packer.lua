vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use({
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  })

  use({ 'navarasu/onedark.nvim' })

  use({ 'nvim-treesitter/nvim-treesitter', { run =  ':TSUpdate' }})
  use({ 'nvim-treesitter/playground' })

  use({ 'ThePrimeagen/harpoon' })

  use({ 'mbbill/undotree' })

  use({ 'tpope/vim-fugitive' })

  use({
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {
		  --- Uncomment the two plugins below if you want to manage the language servers from neovim
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- LSP Support
		  {'neovim/nvim-lspconfig'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-nvim-lsp'},
          {'saadparwaiz1/cmp_luasnip'},
		  {'L3MON4D3/LuaSnip'},
	  }
  })

  use({ 'nvim-lualine/lualine.nvim' })

  use({ 'folke/which-key.nvim' })

  use({ 'numToStr/Comment.nvim' })

  use({ 'simrat39/rust-tools.nvim' })

  use({ 'm4xshen/autoclose.nvim' })

  use({ 'kylechui/nvim-surround', tag = '*' })

  use({ 'tikhomirov/vim-glsl' })

  use({ 'tadmccorkle/markdown.nvim' })

  use({ 'lervag/vimtex' })

  use({ 'norcalli/nvim-colorizer.lua' })

  use({
      "giusgad/pets.nvim",
      requires = {
          "giusgad/hologram.nvim",
          "MunifTanjim/nui.nvim",
      }
  })

  use({
      "L3MON4D3/LuaSnip",
      tag = "v2.*",
      run = "make install_jsregexp"
  })
end)
