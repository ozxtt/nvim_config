
vim.o.completeopt = 'menuone,preview,noselect'

-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "pythonx", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end


-- disable autocommenting
vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = '*',
  callback = function ()
    vim.opt.formatoptions:remove({ 'o' , 'c', 'r'})
  end
})

