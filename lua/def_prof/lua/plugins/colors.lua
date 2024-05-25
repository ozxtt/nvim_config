

function color_init()
    local kan = require('kanagawa')
    local col = require('kanagawa.colors').setup({theme='wave'})
    local pal = col.palette

    -- kan.setup()
    kan.setup({colors =
        {theme = {wave = {
            ui = {
                bg = pal.sumiInk0,
                bg_visual = pal.waveBlue2,
                }
            }}}
    })

    vim.cmd([[colorscheme kanagawa-wave]])
end


local lazy_cfg = {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = color_init,
}


return lazy_cfg
