-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  To update plugins you can run
--    :Lazy update
--
require('lazy').setup {
  -- Use `opts = {}` to force a plugin to be loaded.

  --[[ Editor ]]
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  require 'plugins/lspconfig',
  require 'plugins/conform',
  require 'plugins/cmp',
  require 'plugins/treesitter',
  require 'plugins/lint',
  require 'plugins/autopairs',

  --[[ Visual ]]
  require 'plugins/gitsigns', -- TODO: read about how to use this properly
  require 'plugins/which-key',
  require 'plugins/todo-comments',
  require 'plugins/vscode',
  require 'plugins/transparent',
  require 'plugins/indent_line',

  --[[ Fuzzy Finder ]]
  require 'plugins/telescope',

  --[[ Utilites ]]
  require 'plugins/mini',
  require 'plugins/debug',
  require 'plugins/tmux-navigator',
}

-- vim: ts=2 sts=2 sw=2 et
