
function line_init(_, opts)
    require('lualine').setup(opts)
end


local line_cfg = {
    tabline = {
      lualine_a = {{'buffers', mode = 2}},
      lualine_b = {},
      lualine_c = {{'filename', path = 3}},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {'tabs'}
    },
}


local lazy_cfg = {
    'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons', },
    lazy = false,
    config = line_init,
    opts = line_cfg,
}

return lazy_cfg
