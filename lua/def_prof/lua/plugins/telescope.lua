
local function tele_init(_, opts)
    local builtin = require('telescope.builtin')
    local wk = require("which-key")

    wk.register({ ["<leader>f"] = { name = "+[F]ind" }, })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc='[F]ind [F]ile' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc='[F]ind [B]uffers' })
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc='[F]ind [O]ld file' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc='[F]ind [W]ords (under cursor)' })
    vim.keymap.set('n', '<leader>fl', builtin.live_grep, { desc='[F]ind [L]ive grep' })
    vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc='[F]ind [G]it files' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc='[F]ind [H]elp tags' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc='[F]ind [R]esume' })


    local telescope = require("telescope")
    local telescopeConfig = require("telescope.config")

    -- pcall(telescope.load_extension, 'fzf')

    -- Clone the default Telescope configuration
    -- local vimgrep_arguments = { table.unpack(telescopeConfig.values.vimgrep_arguments) } -- Lua 5.4
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) } -- Lua 5.1

    -- I want to search in hidden/dot files.
    -- table.insert(vimgrep_arguments, "--hidden")
    -- I don't want to search in the `.git` directory.
    -- table.insert(vimgrep_arguments, "--glob")
    -- table.insert(vimgrep_arguments, "!**/.git/*")
    table.insert(vimgrep_arguments, "--max-filesize")
    table.insert(vimgrep_arguments, "100K")

    telescope.setup(opts)
end


local tele_cfg = {
    defaults = {
        -- `hidden = true` is not supported in text grep commands.
        -- vimgrep_arguments = vimgrep_arguments,
        preview = {
                filesize_limit = 0.1, -- MB
            },
    },
    pickers = {
        find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            -- find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            find_command = { "rg", "--files", "--max-filesize", "100K"},
        },
    },
}


local lazy_cfg = {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                      , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim',
        --[[ {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        }, ]]
        },
    cmd = "Telescope",
    keys = {{'<leader>f', desc='+[F]ind (lazy)'}},
    config = tele_init,
    opts = tele_cfg,
  }


return lazy_cfg
