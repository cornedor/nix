{
  pkgs,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    autocd = true;
    syntaxHighlighting = {
      enable = true;
    };
    history = {
      ignoreSpace = true;
      save = 20000;
    };
    oh-my-zsh = {
      enable = false;
      # plugins = ["git" "copyfile" "jira"];
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "plugins/git"; tags = [ "from:oh-my-zsh" ]; }
        { name = "gnachman/iTerm2-shell-integration"; tags = ["use:shell_integration/zsh"]; }
      ];
    };
    dirHashes = {
      nix = "$HOME/.config/nix";
      dev = "$HOME/Development";
      vim = "$HOME/.config/nvim";
    };
  };

  programs.eza = {
    enable = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
    git = true;
    icons = true;
  };

  programs.fzf = {
    enable = true;
  };

  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      ctrl_n_shortcuts = true;
      enter_accept = true;
      update_check = false;
      sync = {
        records = true;
      };
    };
  };

  programs.thefuck = {
    enable = true;
  };

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.starship.enable = true;
  programs.starship.settings = {
    gcloud.disabled = true;
    custom.ddev = {
      detect_folders = [".ddev"];
      command = "cat .ddev/config.yaml | yaml2json | jq -r .php_version";
      when = " test \"$output\" ";
      symbol = " ";
      style = "green bold";
    };
    custom.react = {
      detect_files = ["package.json"];
      detect_folders = ["node_modules"];
      detect_extensions = ["tsx"];
      command = "jq -r .version node_modules/react/package.json || jq -r .dependencies.react package.json";
      symbol = "󰜈 ";
      style = "bold yellow";
      format = ''via [$symbol($output)]($style) '';
    };
    custom.nextjs = {
      detect_files = ["next.config.js"];
      command = "jq -r .version node_modules/next/package.json || jq -r .dependencies.next package.json";
      symbol = "󰇂 ";
      style = "bold light-blue";
      format = ''via [$symbol($output)]($style) '';
    };
  };
}
