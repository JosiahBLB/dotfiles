{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    keyMode = "vi";
    mouse = true;
    shortcut = "a";
    historyLimit = 10000;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      resurrect
      continuum
      {
        plugin = dracula;
        extraConfig = builtins.readFile ./dracula.conf;
      }
    ];
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
