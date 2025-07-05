-- Autocommands configuration
-- See `:help lua-guide-autocommands`

-- Invoke :EslintFixAll on save for .ts, .tsx, .js, .jsx files only on repositories with the name 'lg-*'
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('eslintfixall', { clear = true }),
  pattern = { '*.ts', '*.tsx', '*.js', '*.jsx' },
  callback = function()
    local filename = vim.fn.expand '%:p'
    local repo_name = vim.fn.fnamemodify(vim.fn.system 'git rev-parse --show-toplevel', ':t')
    if string.match(repo_name, '^lg%-') then
      vim.cmd 'EslintFixAll'
    end
  end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
