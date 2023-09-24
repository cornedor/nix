{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    vim-nix
    solarized-nvim
    bufdelete-nvim
  ];

  # colorscheme = "solarized";
  # colorschemes.base16 = {
  #   enable = true;
  #   colorscheme = "solarized-light";
  # };
  colorschemes.rose-pine.enable = true;
  colorschemes.rose-pine.boldVerticalSplit = true;
  colorschemes.rose-pine.dimInactive = true;
  colorschemes.rose-pine.highlightGroups = {
    NeoTreeNormalNC = {
      bg = "highlight_low";
    };
    NeoTreeNormal = {
      bg = "highlight_low";
    };
  };
}
