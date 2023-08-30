{ ... }: {
  home.file."/.config/alacritty/solarized-light.theme.yml".source = "./dotfiles/alacritty/solarized-light.theme.yml";
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "FiraCode Nerd Font";
        size = 12;
      };
      import = ["~/.config/alacritty/solarized-light.theme.yml"];
    };
  };
}
