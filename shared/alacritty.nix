{ ... }: {
  home.file."/.config/alacritty/rose-pine-dawn.theme.toml".source =
    ./dotfiles/alacritty/rose-pine-dawn.theme.toml;
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "FiraCode Nerd Font";
        size = 12;
      };
      general = {
        import = ["~/.config/alacritty/rose-pine-dawn.theme.toml"];
      };
      env = {
        TERM = "xterm-256color";
      };
      window = {
        padding = { x = 5; y = 5; };
        decorations = "None";
      };
    };
  };
}
