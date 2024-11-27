{ lib, ... }:
{
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    rm -f ~/.gitconfig
  '';

  programs.git = {
    enable = true;
    userName = "JBrough";
    userEmail = "josiahbrough@proton.me";
    includes = [ { path = "~/.config/nixpkgs/gitconfig"; } ];
    ignores = [
      "*~"
      ".DS_Store"
    ];
    extraConfig = {
      github.user = "JosiahBLB";
      init = {
        defaultBranch = "main";
      };
      push.autoSetupRemote = true;
    };
  };
}
