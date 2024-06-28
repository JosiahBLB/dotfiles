{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zsh-powerlevel10k
    zsh-autosuggestions
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    dotDir = ".config";
    initExtra = ''
      ${builtins.readFile ./env.sh}
      ${builtins.readFile ./opts.sh}
      ${builtins.readFile ./aliases.sh}
      ${builtins.readFile ./functions.sh}
    '';
    plugins = with pkgs; [
      {
        name = "powerlevel10k";
        src = zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "zsh-autosuggestions";
        src = zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "fast-syntax-highlighting";
        src = zsh-fast-syntax-highlighting;
        file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
      }
    ];
  };
}
