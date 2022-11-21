-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
    use 'folke/tokyonight.nvim'
    use "ThePrimeagen/vim-be-good"

--    use { 'neoclide/coc.nvim', branch = 'release' }

    use {
        'nvim-lualine/lualine.nvim',
        --    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

--    use('editorconfig/editorconfig-vim')

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use { "nvim-telescope/telescope-file-browser.nvim" }
    use("nvim-lua/popup.nvim")

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    --https://github.com/phaazon/hop.nvim
    --Hop is an EasyMotion-like plugin allowing you to jump anywhere in a document with as few keystrokes as possible. It does so by annotating text in your buffer with hints, short string sequences for which each character represents a key to type to jump to the annotated text. Most of the time, those sequences’ lengths will be between 1 to 3 characters, making every jump target in your document reachable in a few keystrokes.
    use {
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    }

    --https://github.com/dense-analysis/ale
    --ALE (Asynchronous Lint Engine) is a plugin providing linting (syntax checking and semantic errors) in NeoVim 0.2.0+ and Vim 8 while you edit your text files, and acts as a Vim Language Server Protocol client.
    use("dense-analysis/ale")
    use("windwp/nvim-ts-autotag")
    use("windwp/nvim-autopairs")
    use('norcalli/nvim-colorizer.lua')

    --https://github.com/preservim/nerdcommenter
    use("preservim/nerdcommenter")
    use("nvim-tree/nvim-web-devicons")

    use {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'}
    use("akinsho/nvim-bufferline.lua")

    use("jose-elias-alvarez/null-ls.nvim")
    use("MunifTanjim/prettier.nvim")
    use("lewis6991/gitsigns.nvim")
    use("lukas-reineke/indent-blankline.nvim")

    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("hrsh7th/cmp-nvim-lsp")
    use("onsails/lspkind-nvim")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/nvim-cmp")
    use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}
    use("nvim-lua/lsp_extensions.nvim")
    use("glepnir/lspsaga.nvim")
    use("simrat39/symbols-outline.nvim")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
end)
