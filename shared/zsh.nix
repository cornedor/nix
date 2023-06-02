{ pkgs, config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    history = {
      ignoreSpace = true;
      save = 20000;
    };
    oh-my-zsh = {
      enable = true;
      # theme = "jispwoso";
      plugins = [ "git" "copyfile" "jira" ];
    };
    dirHashes = {
      nix = "$HOME/.config/nix";
      dev = "$HOME/Development";
    };
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
    extraOptions  =[
      "--group-directories-first"
      "--header"
    ];
    git = true;
    icons = true;
  };

  programs.fzf = {
    enable = true;
  };
}
