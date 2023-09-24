{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    hop-nvim
  ];

  extraConfigLua = ''
    require("hop").setup()

    require("which-key").register({
      h = {
        "<cmd>HopPattern<cr>",
        "Hop to pattern"
      },
      ["<leader>"] = {
        name = "Hop",
        l = {
          "<cmd>HopineStart<cr>",
          "Hop To Line Start"
        },
        w = {
          "<cmd>HopWord<cr>",
          "Hop To Word"
        },
        c = {
          "<cmd>HopChar1<cr>",
          "Hop To Character"
        },
        a = {
          "<cmd>HopAnywhere<cr>",
          "Hop Anywhere"
        },
      },
    }, {
      prefix = "<leader>",
    })
  '';
}
