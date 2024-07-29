
local wk = require("which-key")

wk.add({ {"<leader>n",  group = "[N]etrw" } })
vim.keymap.set("n", "<leader>nl", vim.cmd.Lexplore, {desc = '[L]explore cwd'})
-- vim.keymap.set("n", "<leader>nf", vim.cmd("Lexplore %:p:h"), {desc = '[L]explore cfd'})
vim.keymap.set("n", "<leader>nf", "<cmd>Lexplore %:p:h<CR>", {desc = 'Lexplore c[F]d'})

function set_netrw_mapping(args)
    vim.keymap.set("n", "P", "<C-w>z", {desc = 'close preview', buffer = true})
    vim.keymap.set("n", "<leader>no", "<cmd>Lexplore<CR>",
            {desc = 'Open file and close exp', buffer = true, remap = true})
end

local au_id = vim.api.nvim_create_augroup("netrw_mapping", {clear = true})
vim.api.nvim_create_autocmd("FileType",{
    pattern = 'netrw',
    callback = set_netrw_mapping,
    group = au_id
})
