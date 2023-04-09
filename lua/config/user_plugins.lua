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
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim" } 
  use { "catppuccin/nvim", as = "catppuccin" }
  use { "nvim-tree/nvim-tree.lua", requires = { "nvim-tree/nvim-web-devicons"}  }
  use { "folke/which-key.nvim"}
  use { "akinsho/bufferline.nvim", requires = {"nvim-tree/nvim-web-devicons"}}
  use { "lukas-reineke/indent-blankline.nvim"}
  use { "nvim-lualine/lualine.nvim", requires = { 'nvim-tree/nvim-web-devicons'}}
  use { 'nvim-treesitter/nvim-treesitter'}
  use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} }}
  use { 'lewis6991/gitsigns.nvim'}
  use { 'hrsh7th/nvim-cmp'}
  use { "akinsho/toggleterm.nvim"}
  use { "mfussenegger/nvim-dap"}
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} } 
  use { "nvim-telescope/telescope-dap.nvim" }
  
-- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

