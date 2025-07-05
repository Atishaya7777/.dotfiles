-- Plugin specifications barrel imports
return {
  -- Import all plugin categories
  { import = 'plugins.editor' },
  { import = 'plugins.ui' },
  { import = 'plugins.lsp' },
  { import = 'plugins.completion' },
  { import = 'plugins.git' },
  { import = 'plugins.navigation' },
  { import = 'plugins.treesitter' },
  { import = 'plugins.debug' },
  { import = 'plugins.markdown' },
  { import = 'plugins.tex' },
  
  -- Import existing custom plugins
  { import = 'custom.plugins' },
  
  -- Import kickstart plugins
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
}
