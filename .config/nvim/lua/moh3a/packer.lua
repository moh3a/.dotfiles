-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- telescope
	use {
  		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- colorscheme
	use({ 'rose-pine/neovim', as = 'rose-pine' })

	-- treesitter
	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	
	-- harpoon
	use('theprimeagen/harpoon')

	-- undotree
	use('mbbill/undotree')

	use('tpope/vim-fugitive')

	-- lsp
	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- lsp support
			{ 'neovim/nvim-lspconfig' },
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },

			-- autocompletion
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'hrsh7th/cmp-nvim-lua' },
			{ 'L3MON4D3/LuaSnip' },

			-- snippets
			{ 'L3MON4D3/LuaSnip' },
			{ 'rafamadriz/friendly-snippets' },
		}
	}
end)
