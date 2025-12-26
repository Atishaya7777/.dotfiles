-- Editor enhancement plugins
return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

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
        filetypes = {
          'css',
          'scss',
          'sass',
          'html',
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'json',
          'lua',
          'vim',
        },
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = false, -- Don't highlight color names (too slow)
          RRGGBBAA = true,
          AARRGGBB = false,
          rgb_fn = true,
          hsl_fn = true,
          css = false,
          css_fn = true,
          mode = 'foreground',
        },
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

  -- Autoformat
  {
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = false, timeout_ms = 3000 }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = false, -- Disabled to prevent slowdowns
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        -- Use Prettier for JS/TS (much faster than ESLint)
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        astro = { 'prettier' },
        json = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
      },
      formatters = {
        eslint = {
          -- ESLint caching for faster runs
          args = function(self)
            local args = vim.list_extend(
              { '--stdin-filename', '$FILENAME', '--fix-dry-run', '--format=json' },
              self:get_default_args()
            )
            return args
          end,
        },
        prettier = {
          -- Prettier options for faster formatting
          args = { '--stdin-filepath', '$FILENAME', '--prose-wrap=preserve' },
        },
      },
    },
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false,
      search = {
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--glob=!node_modules',
          '--glob=!.next',
          '--glob=!dist',
        },
      },
    },
  },

  -- Sets the current focused buffer to the center
  {
    'shortcuts/no-neck-pain.nvim',
    version = '*',
  },
}
