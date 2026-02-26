-- UI and theme plugins
return {
  -- Web dev icons
  { 'nvim-tree/nvim-web-devicons', opts = {} },

  -- Colorscheme
  {
    -- 'rebelot/kanagawa.nvim',
    'zenbones-theme/zenbones.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    dependencies = 'rktjmp/lush.nvim',
    lazy = false,
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme 'tokyonight-night'
      -- vim.cmd.colorscheme 'onedark'
      -- vim.cmd.colorscheme 'kanagawa-wave'
      vim.cmd.colorscheme 'zenbones'

      -- Use terminal background instead of colorscheme background
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

      -- You can configure highlights by doing something like:
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },
}
