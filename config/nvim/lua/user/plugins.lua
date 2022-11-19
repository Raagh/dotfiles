local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Base plugins
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  -- Editor UI
  use { -- File tree navigation
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- file icons on nvim-tree
    },
  }
  use "folke/which-key.nvim" -- Keybindings information
  use "glepnir/dashboard-nvim" -- Greeter
  use "nvim-lualine/lualine.nvim" -- Status bar
  use "romgrk/barbar.nvim" -- Tabs support
  use "akinsho/toggleterm.nvim" -- Terminal support
  use "nvim-telescope/telescope.nvim" -- Search functionality

  -- Copilot
  use { "github/copilot.vim" }
  use {
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require "user.copilot"
      end, 100)
    end,
  }
  use "zbirenbaum/copilot-cmp"

  -- Colorscheme
  use "folke/tokyonight.nvim"

  -- Completion
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-nvim-lsp"

  -- Code Snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }
  use "neovim/nvim-lspconfig" -- enable LSP
  use "jose-elias-alvarez/null-ls.nvim" -- Formatting and Linting per language support
  use { "ray-x/lsp_signature.nvim", -- See method signature on LSP suggestions
    config = function()
      require "lsp_signature".setup({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
          border = "rounded"
        }
      }
      )
    end
  }

  -- Syntax highlighting
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- Debugging
  use "mfussenegger/nvim-dap"
  use {
    "rcarriga/nvim-dap-ui",
    commit = "72ac47537690d1a01878bdadc143b487b26c34ca"
  }

  use "theHamsta/nvim-dap-virtual-text"
  use { "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } }
  use {
    "microsoft/vscode-js-debug",
    opt = true,
    run = "npm install --legacy-peer-deps && npm run compile"
  }

  -- Git
  use "lewis6991/gitsigns.nvim"
  use "f-person/git-blame.nvim"

  -- Extra quality of life improvements
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and and treesitter
  use {
    'numToStr/Comment.nvim', -- Allows for commenting code easily
    config = function()
      require('Comment').setup()
    end
  }
  use "anuvyklack/pretty-fold.nvim"
  use "andymass/vim-matchup" -- Allows to move between code better than default vim

  -- Improve performance
  use("nathom/filetype.nvim")
  use 'lewis6991/impatient.nvim'

  -- Extra language support, enable when needed
  -- use "purescript-contrib/purescript-vim" -- Purescript syntax highlighting
  -- use "FrigoEU/psc-ide-vim" -- Adds IDE error diagnostics
  -- use "vmchale/dhall-vim" -- Adds dhall config fils highlighting
  -- use "neoclide/coc.nvim" -- allows using some language plugins that only exist for vscode

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
