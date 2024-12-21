{
  config,
  pkgs,
  lib,
  ...
}:
{

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
      ${builtins.readFile ./keymaps.lua}
    '';
    extraLuaPackages = ps: [ ps.jsregexp ]; # luasnip dep
    plugins = with pkgs.vimPlugins; [
      sensible # better vim defaults
      vim-tmux-navigator # tmux pane and vim-split aware switching
      vim-sleuth # detect tabstop and shiftwidth automatically
      which-key-nvim # key binding help
      vim-visual-multi # multi-cursors like in vscode

      # keymaps for surrounding selections with any character i.e {} or []
      {
        plugin = nvim-surround;
        type = "lua";
        config = ''require("nvim-surround").setup()'';
      }

      # fuzzy finder
      telescope-ui-select-nvim # BUG: Not currently working
      telescope-fzf-native-nvim
      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/telescope.lua;
      }

      # comment out lines using 'gcc' (line) and 'gbc' (block) key combinations
      {
        plugin = comment-nvim;
        type = "lua";
        config = ''require("Comment").setup()'';
      }

      # graphical improvements
      nvim-web-devicons # nerd font icons
      neo-tree-nvim # vscode like file explorer
      {
        plugin = todo-comments-nvim;
        type = "lua";
        config = ''vim.api.nvim_set_hl(0, '@lsp.type.comment', {})'';
      }
      {
        plugin = fidget-nvim; # lsp status updates
        type = "lua";
        config = "require('fidget').setup()";
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/gitsigns.lua;
      }
      {
        plugin = vscode-nvim; # theme
        config = "colorscheme vscode";
      }
      {
        plugin = indent-blankline-nvim; # indentation guides
        type = "lua";
        config = ''require('ibl').setup({ indent = { char = '│' },})'';
      }
      lspkind-nvim # vscode-like LSP pictograms | https://github.com/onsails/lspkind.nvim/

      /**
        Language Features
      */

      # syntax highlighting
      {
        plugin = (nvim-treesitter.withAllGrammars); # TODO: Use only required langs
        type = "lua";
        config = ''require("nvim-treesitter.configs").setup({ highlight = { enable = true, }})'';
      }

      # snippets
      # TODO: add vim-doge
      friendly-snippets # vscode-like snippets
      {
        plugin = luasnip;
        type = "lua";
        config = ''require("luasnip.loaders.from_vscode").lazy_load()'';
      }

      # auto-format
      {
        plugin = conform-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/auto-format.lua;
      }

      # auto-completion
      {
        plugin = nvim-cmp; # https://github.com/hrsh7th/nvim-cmp
        type = "lua";
        config = builtins.readFile ./plugins/auto-completion.lua;
      }
      cmp-buffer # current buffer as completion source | https://github.com/hrsh7th/cmp-buffer/
      cmp-path # file paths as completion source | https://github.com/hrsh7th/cmp-path/
      cmp-nvim-lua # neovim lua API as completion source | https://github.com/hrsh7th/cmp-nvim-lua/
      cmp-nvim-lsp # LSP as completion source | https://github.com/hrsh7th/cmp-nvim-lsp/
      cmp_luasnip # snippets autocompletion extension for nvim-cmp | https://github.com/saadparwaiz1/cmp_luasnip/
      cmp-nvim-lsp-signature-help # https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/
      nvim-autopairs # crate matching brackets

      # lsp
      {
        plugin = neodev-nvim;
        type = "lua";
        config = ''require('neodev').setup({library = { plugins = { "nvim-dap-ui" }, types = true }, })'';
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./plugins/lsp.lua;
      }
    ];
  };
  home.packages = with pkgs; [
    # LSP (./plugins/lsp.lua)
    clang-tools # bundled c/cpp tools
    cmake-language-server
    pyright # python
    lua-language-server
    nodePackages_latest.typescript-language-server
    nodePackages_latest.bash-language-server
    nil # nix
    zls

    # FORMATTERS
    nixfmt-rfc-style
    ruff # python
    isort # python
    stylua # lua
    prettierd # typescript
    cmake-format
    shfmt

    # LANGUAGES
    lua

    # DEPENDECIES
    lua52Packages.jsregexp # luasnip dep
  ];
}
