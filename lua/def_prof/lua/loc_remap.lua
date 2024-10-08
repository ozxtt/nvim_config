
local wk = require("which-key")

local function toggle_opt(opt)
    vim.opt[opt] = not(vim.opt[opt]:get())
end

-- move visual block up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = 'move selection up'})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc = 'move selection down'})

-- paste over selection without overwriting the buffer
vim.keymap.set("x", "p", [["_dP]])

-- copy into a system buffer
vim.keymap.set({"n", "v"}, "<leader>P", [["*p]], {desc = '[P]aste from vis sel (F9)'})
vim.keymap.set({"n", "v"}, "<F9>", [["*p]], {desc = '[P]aste from vis sel (F9)'})
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], {desc = '[Y]ank into sys clip (F10)'})
vim.keymap.set({"n", "v"}, "<F10>", [["+y]], {desc = '[Y]ank into sys clip (F10)'})
vim.keymap.set({"n", "v"}, "<leader>p", [["+p]], {desc = '[P]aste from sys clip (F11)'})
vim.keymap.set({"n", "v"}, "<F11>", [["+p]], {desc = '[P]aste from sys clip (F11)'})
-- 2DO: fix paste toggle
vim.keymap.set("i", "<C-o>", "<C-R>+", {desc = '[P]aste from sys clip'})

-- delete to void
vim.keymap.set({"n", "v"}, "<leader>D", [["_d]], {desc = '[D]elete to void'})

vim.keymap.set({"n", "v"}, "'", "`")

-- diff
wk.add({ {"<leader>d",  group = "[D]iff" } })
vim.keymap.set("n", "<leader>dg", function() return ":.,.+" .. vim.v.count .. "diffget<CR>" end, {desc = 'Diff [G]et', expr = true})
vim.keymap.set("n", "<leader>dp", function() return ":.,.+" .. vim.v.count .. "diffput<CR>" end, {desc = 'Diff [P]ut', expr = true})
vim.keymap.set("v", "<leader>dg", ":'<,'>diffget<CR>", {desc = 'Diff [G]et'})
vim.keymap.set("v", "<leader>dp", ":'<,'>diffput<CR>", {desc = 'Diff [P]ut'})
vim.keymap.set("n", "<leader>dt", vim.cmd.diffthis, {desc = 'Diff [T]his'})
vim.keymap.set("n", "<leader>do", vim.cmd.diffoff, {desc = 'Diff [O]ff'})
-- switch buffers
wk.add({ {"<leader>b",  group = "[B]uf" } })
vim.keymap.set("n", "<S-Right>", vim.cmd.bnext, {desc = 'Next buf'})
vim.keymap.set("n", "<S-Left>", vim.cmd.bprevious, {desc = 'Prev buf'})
vim.keymap.set("n", "<leader>bl", vim.cmd.ls, {desc = '[L]ist [B]ufs'})
vim.keymap.set("n", "<leader>bq", vim.cmd.bdelete, {desc = 'Delete Buf'})
vim.keymap.set("n", "<S-Down>", vim.cmd.bdelete, {desc = 'Delete Buf'})
vim.keymap.set("n", "<S-Up>", vim.cmd.write, {desc = 'Write Buf'})

local function switch_buf()
    local buf_num = vim.fn.getbufinfo({buflisted=1})[vim.v.count1]['bufnr']
    return "<cmd>" .. buf_num .. "b<CR>"
end

vim.keymap.set("n", "<leader><Space>", switch_buf,  {expr = true, desc = '#Switch to buf'})

--
vim.keymap.set("n", "gV", "`[v`]", {desc = '[V]isually select pasted text'})
vim.keymap.set("n", "<leader>q", vim.cmd.quit, {desc = '[Q]uit'})
vim.keymap.set("n", "<leader>a", vim.cmd.qall, {desc = 'quit [A]ll'})

wk.add({ {"<leader>t",  group = "[T]oggle" } })
-- vim.keymap.set("n", "<leader>th", ':set hlsearch!<CR>', {desc = 'toggle [H]lsearch (F1)'})
vim.keymap.set("n", "<leader>th", function() toggle_opt('hlsearch') end, {desc = 'toggle [H]lsearch (F1)'})
vim.keymap.set({"n", 'v', 'i'}, "<F1>", function() toggle_opt('hlsearch') end, {desc = 'toggle [H]lsearch (F1)'})
vim.keymap.set("n", "<leader>tp", function() toggle_opt('paste') end, {desc = 'toggle [P]aste (F3)'})
vim.keymap.set({"n", 'v', 'i'}, "<F3>", function() toggle_opt('paste') end, {desc = 'toggle [P]aste (F3)'})
vim.opt.spelllang = 'en_us'
vim.keymap.set("n", "<leader>ts", function() toggle_opt('spell') end, {desc = 'toggle [S]pell (F2)'})
vim.keymap.set({"n", 'v', 'i'}, "<F2>", function() toggle_opt('spell') end, {desc = 'toggle [S]pell (F2)'})


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

