-- Keymap configuration
-- See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Keybinds for soft navigating the wrapped lines
vim.keymap.set('n', 'j', 'gj', { desc = 'Soft navigate the wrapped line down.' })
vim.keymap.set('n', 'k', 'gk', { desc = 'Soft navigate the wrapped line up.' })

-- Keybinds for actually deleting instead of cutting stuff
vim.keymap.set('n', 'd', '"_d', { desc = 'Cut text and put it in the black hole register | Effectively deleting it' })
vim.keymap.set('n', 'dp', '"_dP', { desc = 'Paste the text from the black hole register' })

-- Keybinds for cutting text
vim.keymap.set('n', 'cx', 'yydd', { desc = 'Cut text as you would do normally outside of vim' })

-- Keybinds for buffers
vim.keymap.set('n', '<leader>x', ':bp|bd#<CR>', { desc = 'Delete current buffer' })
vim.keymap.set('n', 'bp', ':bprevious<CR>', { desc = 'Go to previoous buffer' })
vim.keymap.set('n', 'bn', ':bnext<CR>', { desc = 'Go to next buffer' })

vim.keymap.set('n', 'cub', function()
  local bufinfos = vim.fn.getbufinfo { buflisted = true }
  vim.tbl_map(function(bufinfo)
    if bufinfo.changed == 0 and (not bufinfo.windows or #bufinfo.windows == 0) then
      print(('Deleting buffer %d : %s'):format(bufinfo.bufnr, bufinfo.name))
      vim.api.nvim_buf_delete(bufinfo.bufnr, { force = false, unload = false })
    end
  end, bufinfos)
end, { desc = '[C]lear [U]nused [B]uffers that are not shown currently in a window' })

vim.keymap.set('n', 'crd', ':!crd', { desc = 'Create a React directory' })

-- Keybind to toggle diffview for git
vim.keymap.set('n', '<leader>gd', function()
  if next(require('diffview.lib').views) == nil then
    vim.cmd 'DiffviewOpen'
  else
    vim.cmd 'DiffviewClose'
  end
end, { desc = 'Toggle [G]it [D]iffview' })
