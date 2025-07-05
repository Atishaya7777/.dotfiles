-- Editor enhancement plugins
return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  
  -- GitHub Copilot
  'github/copilot.vim',
  
  -- Async library
  'nvim-neotest/nvim-nio',
  
  -- Surround text objects
  {
    'kylechui/nvim-surround',
    version = '^3.0.0', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  
  -- Color highlighter for hex/rgb/rgba codes
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup {
        '*',
      }
    end,
  },
  
  -- Comment toggle
  { 'numToStr/Comment.nvim', opts = {} },
  
  -- Collection of various small independent plugins/modules
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  
  -- Promise dependency for nvim-ufo
  { 'kevinhwang91/promise-async' },
  
  -- Code folding
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function() end,
  },
  
  -- Autoformat
  {
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = {
          -- typescript = true,
          -- javascript = true,
          -- javascriptreact = true,
          -- typescriptreact = true,
          astro = true,
        }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        -- NOTE: Removed this chunk because it kept interfering with LG work
        javascript = { { 'eslint' } },
        typescript = { { 'eslint' } },
        javascriptreact = { { 'eslint' } },
        typescriptreact = { { 'eslint' } },
        astro = { { 'eslint', 'prettier' } },
      },
    },
  },
  
  -- Highlight todo, notes, etc in comments
  { 
    'folke/todo-comments.nvim', 
    event = 'VimEnter', 
    dependencies = { 'nvim-lua/plenary.nvim' }, 
    opts = { signs = false } 
  },
}
