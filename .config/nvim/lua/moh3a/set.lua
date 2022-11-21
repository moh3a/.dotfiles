vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.incsearch = false

vim.opt.smartindent = true

vim.opt.wrap = false

vim.g.mapleader = " "

-- https://github.com/preservim/nerdcommenter
vim.g.NERDCreateDefaultMappings = 1

require('lualine').setup {
    options = {
        theme = "tokyonight"
    }
}

vim.opt.list = true
vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    show_end_of_line = true,
}

-- dense-analysis / ale
vim.g.ale_fix_on_save = 1

-- nvim-tree
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
require("nvim-tree").setup()

-- THEME
require("tokyonight").setup({
  style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
--  light_style = "day", -- The theme is used when the background is set to light
  transparent = true, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = { italic = true },
    variables = { italic = true },
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "transparent", -- style for sidebars, see below
    floats = "transparent", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = true, -- dims inactive windows
  lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
})


-- LSP tool: mason
-- If you need additional LSP support for specific libraries, you may need williamboman/mason.nvim and williamboman/mason-lspconfig.nvim.
--I use them for getting Tailwind CSS language server to work on Neovim.
local status, mason = pcall(require, "mason")
if (not status) then return end
local status2, masonlspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

mason.setup({})

masonlspconfig.setup {
  ensure_installed = { "sumneko_lua", "tailwindcss" },
}

-- LSP CONFIG
-- Neovim has a built-in LSP support.
--You can easily configure it by using neovim/nvim-lspconfig.
--For example, to enable typescript language server on Neovim:
local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
  -- format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.formatting_seq_sync() end
    })
  end
end

-- TypeScript
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" }
}
nvim_lsp.tailwindcss.setup {}
--Don't forget to install typescript language server itself: npm i -g typescript-language-server

-- Auto-completion: Lspkind and cmp
--
-- To get LSP-aware auto-completion feature with fancy pictograms, I use the following plugins:
--onsails/lspkind-nvim - VSCode-like pictograms
--L3MON4D3/LuaSnip - Snippet engine
--hrsh7th/cmp-nvim-lsp - nvim-cmp source for neovim's built-in LSP
--hrsh7th/cmp-buffer - nvim-cmp source for buffer words
--hrsh7th/nvim-cmp - A completion engine plugin for neovim
--
--Configure it like so:
local status, cmp = pcall(require, "cmp")
if (not status) then return end
local lspkind = require 'lspkind'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })
  }
})

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]


-- Syntax highlightings: Treesitter
--
-- Treesitter is a popular language parser for syntax highlightings.
-- Install nvim-treesitter/nvim-treesitter with Packer and configure it like so:
local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },

  -- A list of parser names, or "all"
  ensure_installed = {"c", "rust","javascript", "typescript",
    "tsx",
    "toml",
    "fish",
    "json",
    "yaml",
    "css",
    "html",
    "lua"
  },
  autotag = {
    enable = true,
  },
   -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,

}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

-- Autotag and Autopair
-- For React apps, you often want to close tags quickly.
--windwp/nvim-ts-autotag is exactly what you want.
local status, autotag = pcall(require, "nvim-ts-autotag")
if (not status) then return end

autotag.setup({})
-- windwp/nvim-autopairs is for closing brackets.
local status, autopairs = pcall(require, "nvim-autopairs")
if (not status) then return end

autopairs.setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

-- Fuzz finder: Telescope
-- telescope.nvim provides an interactive fuzzy finder over lists, built on top of the latest Neovim features.
--I also use telescope-file-browser.nvim as a filer.
--It’s so useful because you can search files while viewing the content of the files without actually opening them. It supports various sources like Vim, files, Git, LSP, and Treesitter. Check out the showcase of Telescope.
--Install kyazdani42/nvim-web-devicons to get file icons on Telescope, statusline, and other supported plugins.
--The configuration would look like so:
local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  },
}

-- keymaps
vim.keymap.set('n', ';f',
  function()
    builtin.find_files({
      no_ignore = false,
      hidden = true
    })
  end)
vim.keymap.set('n', ';r', function()
  builtin.live_grep()
end)
vim.keymap.set('n', '\\\\', function()
  builtin.buffers()
end)
vim.keymap.set('n', ';t', function()
  builtin.help_tags()
end)
vim.keymap.set('n', ';;', function()
  builtin.resume()
end)
vim.keymap.set('n', ';e', function()
  builtin.diagnostics()
end)

--Use the telescope browser extension:
telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        -- your custom insert mode mappings
        ["i"] = {
          ["<C-w>"] = function() vim.cmd('normal vbd') end,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd('startinsert')
          end
        },
      },
    },
  },
}
telescope.load_extension("file_browser")

vim.keymap.set("n", "sf", function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = "normal",
    layout_config = { height = 40 }
  })
end)



-- LSP Uls: Lspsaga
--glepnir/lspsaga.nvim is one of my favorite LSP plugins.
--It provides beautiful UIs for various LSP-related features like hover doc, definition preview, and rename actions.
--My configuration is simple:
local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.init_lsp_saga {
  server_filetype_map = {
    typescript = 'typescript'
  }
}

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga preview_definition<CR>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)

-- TABS: Barbar
local nvim_tree_events = require('nvim-tree.events')
local bufferline_api = require('bufferline.api')

local function get_tree_size()
  return require'nvim-tree.view'.View.width
end

nvim_tree_events.subscribe('TreeOpen', function()
  bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('Resize', function()
  bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('TreeClose', function()
  bufferline_api.set_offset(0)
end)

-- Code formatter: Prettier and null-ls
--I heavily rely on Prettier to format TypeScript/JavaScript/CSS files.
--Use jose-elias-alvarez/null-ls.nvim and MunifTanjim/prettier.nvim to accomplish that.
--First, you need prettierd: brew install prettierd
--Then, configure null-ls and prettier as following:
local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
    null_ls.builtins.diagnostics.fish
  }
})
local status, prettier = pcall(require, "prettier")
if (not status) then return end

prettier.setup {
  bin = 'prettierd',
  filetypes = {
    "css",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "scss",
    "less"
  }
}

-- Git markers: gitsigns
-- lewis6991/gitsigns.nvim provides git decorations for current buffers.
--It helps you know which lines are currently changed.
--It works out of the box.
require('gitsigns').setup {}
require('colorizer').setup {}
