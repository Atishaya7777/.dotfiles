-- undotree
-- https://github.com/mbbill/undotree/tree/master

return {
  'mbbill/undotree',
  config = function()
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
  end,
}
