
local function toggle_diagnostics(global)
	local vars, bufnr, cmd, msg
	if global then
		vars = vim.g
		bufnr = nil
        msg = 'global'
	else
		vars = vim.b
		bufnr = 0
        msg = 'local'
	end
	vars.diagnostics_disabled = not vars.diagnostics_disabled
	if vars.diagnostics_disabled then
		cmd = 'disable'
        vim.notify(string.format("Lsp disabled (%s)", msg))
	else
		cmd = 'enable'
        vim.notify(string.format("Lsp enabled (%s)", msg))
	end
	vim.schedule(function() vim.diagnostic[cmd](bufnr) end)
end



vim.api.nvim_create_user_command('NvimLspToggle', toggle_diagnostics, {})
vim.api.nvim_create_user_command('NvimLspToggleLoc', function() toggle_diagnostics(false) end, {})

vim.keymap.set("n", "<leader>tL", "<cmd>NvimLspToggle<CR>", {desc='toggle [L]sp global'})
vim.keymap.set("n", "<leader>tl", "<cmd>NvimLspToggleLoc<CR>", {desc='toggle [l]sp local'})



local servers = {
    lua_ls = {
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
        },
    },
    bashls = {},
    pylsp = {},
    texlab = {},
  }

local function lspcfg_init()
    local lspconfig = require("lspconfig")

    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- dependency for lsp server
    -- local mason = require('mason')

    local keymap = vim.keymap -- for conciseness

    local opts = { noremap = true, silent = true }

    local wk = require("which-key")

    wk.register({ ["<leader>l"] = { name = "+[L]sp" }, })

    local on_attach = function(_, bufnr)

        print('attach (lsp)')

        if vim.b[bufnr].diagnostics_disabled or vim.g.diagnostics_disabled then
                vim.diagnostic.disable(bufnr)
            end

        opts.desc = "[r]eferences"
        keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "[D]eclaration"
        keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "[d]efinitions"
        keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "[i]mplementations"
        keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "[t]ype definitions"
        keymap.set("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "code [a]ctions"
        keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "[s]mart rename"
        keymap.set("n", "<leader>ls", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "[b]uffer diagnostics"
        keymap.set("n", "<leader>lb", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "[l]ine diagnostics"
        keymap.set("n", "<leader>ll", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "documentation under [k]ursor"
        keymap.set("n", "<leader>lk", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
        -- Lesser used LSP functionality
        -- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        -- nmap('<leader>wl', function()
        --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, '[W]orkspace [L]ist Folders')
    end

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    for sn, ss in pairs(servers) do
        lspconfig[sn].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = ss,
            filetypes = (ss or {}).filetypes,
        })
    end
end


local lazy_cfg = {
    'neovim/nvim-lspconfig',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        },
    event = { "BufReadPre", "BufNewFile" },
    -- event = { "VeryLazy", },
    config = lspcfg_init,
}


return lazy_cfg
