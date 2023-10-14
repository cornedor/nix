{ ... }: {
  home.file."/.config/alacritty/catppuccin-latte.theme.yml".source =
    ./dotfiles/alacritty/catppuccin-latte.theme.yml;
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "FiraCode Nerd Font";
        size = 12;
      };
      import = ["~/.config/alacritty/catppuccin-latte.theme.yml"];
      env = {
        TERM = "xterm-256color";
      };
      window = {
        padding = { x = 5; y = 5; };
      };
    };
  };
}
