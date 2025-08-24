-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable", -- latest stable release
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- In ~/.config/nvim/init.lua

require("lazy").setup({
  -- Your theme (already installed)
  {
    "morhetz/gruvbox",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.cmd.colorscheme "gruvbox"
    end,
  },

  -- LSP and Autocompletion plugins
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  { "williamboman/mason-lspconfig.nvim" }, -- Bridge between mason and lspconfig
  { "neovim/nvim-lspconfig" },            -- Main LSP configuration plugin

  -- Autocompletion engine
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" }, -- Source for LSP suggestions
})

-- This code goes AFTER your lazy.setup({...}) block

-- ## LSP Configuration ##
-- ## LSP Configuration ##
local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

-- Configure mason-lspconfig to automatically install and manage servers
mason_lspconfig.setup({
  -- A list of servers to automatically install if they're not already installed.
  -- The correct name for the ruff language server is "ruff", not "ruff_lsp".
  ensure_installed = { "pyright", "ruff" },

  -- This is the crucial part: `setup_handlers` is a key *within* the setup call.
  -- It defines how to set up each server after it has been installed.
  handlers = {
    function(server_name)
      -- This sets up the server with default capabilities
      lspconfig[server_name].setup({})
    end,
  },
})

-- ## Autocompletion Configuration ##
local cmp = require("cmp")

cmp.setup({
  sources = {
    { name = "nvim_lsp" }, -- Use LSP as a source for suggestions
  },
  -- Keybindings for autocompletion
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(), -- Next suggestion
    ['<C-p>'] = cmp.mapping.select_prev_item(), -- Previous suggestion
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection
  },
})



