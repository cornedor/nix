{
  # Import all your configuration modules here
  imports = [
    ./colorscheme.nix
    ./bufferline.nix
    ./telescope.nix
    ./neo-tree.nix
    ./cmp.nix
    ./lsp.nix
    ./which-key.nix
    ./hop.nix
    ./lualine.nix
    ./git.nix
    ./indent-blankline.nix
    ./dashboard.nix
  ];

  config = {
    editorconfig.enable = true;

    globals = {
      mapleader = " ";
    };

    options = {
      number = true;
      relativenumber = true;
      cursorline = true;
      shiftwidth = 2;
    };

    plugins = {
      nix.enable = true;
      illuminate.enable = true;
    };

    extraConfigLua = ''
      require("which-key").register({
        q = {
          "<cmd>Bdelete<cr>",
          "Close buffer",
        },
      }, {
        prefix = "<leader>",
      })
    '';
  };
}
