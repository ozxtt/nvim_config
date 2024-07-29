

local function sign_init()
    -- require('gitsigns').setup()
    require('gitsigns').setup({

      on_attach = function(bufnr)
        print('attach (git)')
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc='next hunk'})

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc='prev hunk'})

        map('n', '<leader>gs', gs.stage_hunk, {desc='[s]tage hunk'})
        map('n', '<leader>gS', gs.stage_buffer, {desc='[S]tage buff'})
        map('n', '<leader>gr', gs.reset_hunk, {desc='[r]eset hunk'})
        map('n', '<leader>gR', gs.reset_buffer, {desc='[R]eset buff'})
        map('n', '<leader>gu', gs.undo_stage_hunk, {desc='[u]ndo stage hunk'})
        map('n', '<leader>gp', gs.preview_hunk, {desc='[p]review hunk'})
        map('n', '<leader>gP', gs.preview_hunk_inline, {desc='[P]review hunk inline'})
        map('n', '<leader>gb', function() gs.blame_line{full=true} end, {desc='[b]lame line'})
        map('n', '<leader>gB', gs.toggle_current_line_blame, {desc='[B]lame toggle'})
        map('n', '<leader>gd', gs.diffthis, {desc='[d]iff with commit'})
        map('n', '<leader>gD', function() gs.diffthis('~') end, {desc='[D]iff with index'})
        map('n', '<leader>gx', gs.toggle_deleted, {desc='toggle deleted'})
        local wk = require("which-key")
        wk.add({ {"<leader>g", group = "[G]it" } })

    end
    })
end



local lazy_cfg = {
    'lewis6991/gitsigns.nvim',
    -- lazy = true,
    -- lazy = false,
    -- event = { "BufReadPre", "BufNewFile" },
    event = { "VeryLazy", },
    -- keys = {{'<leader>g', desc='+[G]it (lazy)'},
    --         {']c', desc='next hunk (lazy)'},
    --         {'[c', desc='prev hunk (lazy)'}},
    config = sign_init,
    -- config = sign_init2,
    -- config = true,
}


return lazy_cfg
