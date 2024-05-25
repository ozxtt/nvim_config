
local wk = require("which-key")

local function toggle_opt(opt)
    vim.opt[opt] = not(vim.opt[opt]:get())
end

-- move visual block up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = 'move selection up'})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc = 'move selection down'})

-- paste over selection without overwriting the buffer
vim.keymap.set("x", "<leader>p", [["_dP]])

-- copy into a system buffer
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], {desc = '[Y]ank into sys clip'})
vim.keymap.set({"n", "v"}, "<leader>p", [["+p]], {desc = '[P]aste from sys clip'})
-- 2DO: fix paste toggle
vim.keymap.set("i", "<C-o>", "<C-R>+", {desc = '[P]aste from sys clip'})

-- delete to void
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], {desc = '[D]elete to void'})

-- switch buffers
wk.register({ ["<leader>b"] = { name = "+[B]uf" }, })
vim.keymap.set("n", "<S-Right>", vim.cmd.bnext, {desc = 'Next buf'})
vim.keymap.set("n", "<S-Left>", vim.cmd.bprevious, {desc = 'Prev buf'})
vim.keymap.set("n", "<leader><Space>", function()
    return "<cmd>" .. vim.v.count1 .. "b<CR>" end, {expr = true, desc = '#Switch to buf'})
vim.keymap.set("n", "<leader>bl", vim.cmd.ls, {desc = '[L]ist [B]ufs'})
vim.keymap.set("n", "<leader>bq", vim.cmd.bdelete, {desc = 'Delete Buf'})
vim.keymap.set("n", "<S-Down>", vim.cmd.bdelete, {desc = 'Delete Buf'})
vim.keymap.set("n", "<S-Up>", vim.cmd.write, {desc = 'Write Buf'})

--
vim.keymap.set("n", "gV", "`[v`]", {desc = '[V]isually select pasted text'})
vim.keymap.set("n", "<leader>q", vim.cmd.quit, {desc = '[Q]uit'})

wk.register({ ["<leader>t"] = { name = "+[T]oggle" }, })
-- vim.keymap.set("n", "<leader>th", ':set hlsearch!<CR>', {desc = 'toggle [H]lsearch (F1)'})
vim.keymap.set("n", "<leader>th", function() toggle_opt('hlsearch') end, {desc = 'toggle [H]lsearch (F1)'})
vim.keymap.set({"n", 'v', 'i'}, "<F1>", function() toggle_opt('hlsearch') end, {desc = 'toggle [H]lsearch (F1)'})
vim.keymap.set("n", "<leader>tp", function() toggle_opt('paste') end, {desc = 'toggle [P]aste (F3)'})
vim.keymap.set({"n", 'v', 'i'}, "<F3>", function() toggle_opt('paste') end, {desc = 'toggle [P]aste (F3)'})
vim.opt.spelllang = 'en_us'
vim.keymap.set("n", "<leader>ts", function() toggle_opt('spell') end, {desc = 'toggle [S]pell (F2)'})
vim.keymap.set({"n", 'v', 'i'}, "<F2>", function() toggle_opt('spell') end, {desc = 'toggle [S]pell (F2)'})

-- wk.register({ ["<leader>g"] = { name = "+[G]it" , r = {'', 'test'}}, })
-- wk.register({ ["<leader>z"] = { name = "+[T]oggle" }, })

local function feedkeys(arg)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(arg, true, false, true), 'm', false)
end

local function visual_store(arg)
    local lomark = string.lower(string.char(arg))
    local himark = string.upper(lomark)
    vim.api.nvim_buf_set_mark(0, lomark, vim.fn.line('v'), 0, {})
    vim.api.nvim_buf_set_mark(0, himark, vim.fn.line('.'), 0, {})
    -- vim.api.nvim_input('<ESC>')
    feedkeys('<ESC>')
end

local function visual_recall(arg)
    local lomark = string.lower(string.char(arg))
    local himark = string.upper(lomark)
    -- vim.api.nvim_input(string.format("'%sV'%s", lomark, himark))
    feedkeys(string.format("'%sV'%s", lomark, himark))
end

vim.keymap.set("v", "m", function() visual_store(vim.fn.getchar()) end, {desc = '[M]ark block'})
vim.keymap.set("n", "<leader>m", function() visual_recall(vim.fn.getchar()) end, {desc = 'select [M]arked block'})

