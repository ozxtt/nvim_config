
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, {desc = '[U]ndo tree'})


local lazy_cfg = {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
  }


return lazy_cfg
