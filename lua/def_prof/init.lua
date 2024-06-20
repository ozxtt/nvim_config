--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local localpath = vim.fn.stdpath("config") .. "/lua/def_prof"

vim.opt.rtp:prepend(localpath)

-- print(vim.inspect(vim.opt.rtp))
-- print(vim.inspect(vim.api.nvim_list_runtime_paths()))

require('loc_lazy')

-- print(vim.inspect(vim.opt.rtp))
-- print(vim.inspect(vim.api.nvim_list_runtime_paths()))

-- for whatever reason, lazy removes the previously added path
vim.opt.rtp:prepend(localpath)

require('loc_opts')

require('loc_remap')

require('loc_netrw')

