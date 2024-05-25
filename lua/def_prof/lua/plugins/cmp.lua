
local function toggle_autocomplete()
  local cmp = require('cmp')
  local current_setting = cmp.get_config().completion.autocomplete
  if current_setting and #current_setting > 0 then
    cmp.setup({ completion = { autocomplete = false } })
    vim.notify('Autocomplete disabled (global)')
  else
    cmp.setup({ completion = { autocomplete = { cmp.TriggerEvent.TextChanged } } })
    vim.notify('Autocomplete enabled (global)')
  end
end

local function toggle_autocomplete_loc()
  if vim.fn.exists("b:cmp") == 0 or vim.api.nvim_buf_get_var(0, "cmp") then
    vim.api.nvim_buf_set_var(0, "cmp", false)
    require("cmp").setup.buffer({ enabled = false })
    vim.notify('Autocomplete disabled (local)')
  else
    vim.api.nvim_buf_set_var(0, "cmp", true)
    require("cmp").setup.buffer({ enabled = true })
    vim.notify('Autocomplete enabled (local)')
  end
end

vim.api.nvim_create_user_command('NvimCmpToggle', toggle_autocomplete, {})
vim.api.nvim_create_user_command('NvimCmpToggleLoc', toggle_autocomplete_loc, {})

vim.keymap.set("n", "<leader>tC", "<cmd>NvimCmpToggle<CR>", {desc='toggle [C]mp'})
vim.keymap.set("n", "<leader>tc", "<cmd>NvimCmpToggleLoc<CR>", {desc='toggle [c]mp local'})


local function cmp_init()
    local cmp = require("cmp")

    local luasnip = require("luasnip")

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),
    })
end



local lazy_cfg = {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has 'win32' == 1 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
        "hrsh7th/cmp-buffer", -- source for text in buffer
        "hrsh7th/cmp-path", -- source for file system paths
        "hrsh7th/cmp-nvim-lsp-signature-help",
    },

    event = "InsertEnter",
    -- lazy = false,
    config = cmp_init,
    -- opts = cmp_cfg,
}


return lazy_cfg
