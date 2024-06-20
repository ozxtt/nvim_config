local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git.exe",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {

    require('plugins.colors'),

    -- "gc"/"gb" to comment visual regions/lines
    require('plugins.comment'),

    -- Fuzzy Finder (files, lsp, etc)
    require('plugins.telescope'),

    -- ' u' to toggle
    require('plugins.undotree'),

    require('plugins.treesitter'),

    require('plugins.lualine'),

    require('plugins.gitsigns'),

    -- completion engine
    require('plugins.cmp'),

    -- lsp server installation / configuration
    require('plugins.mason'),

    require('plugins.lspconfig'),

    require('plugins.which_key'),
}

local opts = {defaults = {lazy = true}}


require("lazy").setup(plugins, opts)
