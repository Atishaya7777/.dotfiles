-- Autocommands configuration
-- See `:help lua-guide-autocommands`

-- Cache for repository checks to avoid running git commands on every save
local repo_cache = {}
local function is_lg_repo()
  local cwd = vim.fn.getcwd()
  if repo_cache[cwd] ~= nil then
    return repo_cache[cwd]
  end
  
  local handle = io.popen('git rev-parse --show-toplevel 2>/dev/null')
  if not handle then
    repo_cache[cwd] = false
    return false
  end
  
  local result = handle:read('*a')
  handle:close()
  
  if result and result ~= '' then
    local repo_name = vim.fn.fnamemodify(result:gsub('\n', ''), ':t')
    local is_lg = string.match(repo_name, '^lg%-') ~= nil
    repo_cache[cwd] = is_lg
    return is_lg
  end
  
  repo_cache[cwd] = false
  return false
end

-- Invoke :EslintFixAll on save for .ts, .tsx, .js, .jsx files only on repositories with the name 'lg-*'
-- NOTE: This is now cached and only runs in lg-* repos
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('eslintfixall', { clear = true }),
  pattern = { '*.ts', '*.tsx', '*.js', '*.jsx' },
  callback = function()
    if is_lg_repo() then
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
