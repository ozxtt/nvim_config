
local lspconfig_cfg = {
    ensure_installed = {
        "lua_ls",
        "bashls",
        "pylsp",
        "texlab",
    },
    automatic_installation = false,
}


local mason_cfg = {
    PATH = 'append', -- use system lsp if available
}



function mason_init()
    local mason = require('mason')
    local lspconfig = require('mason-lspconfig')
    mason.setup(mason_cfg)
    lspconfig.setup(lspconfig_cfg)
end


local lazy_cfg = {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',},
    -- lazy = false,
    event = "VeryLazy",
    config = mason_init,
    -- opts = mason_cfg,
}


return lazy_cfg
