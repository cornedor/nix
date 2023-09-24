{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    luasnip
  ];
  plugins.luasnip = {
    enable = true;
  };
  plugins.nvim-cmp = {
    enable = true;
    snippet.expand = "luasnip";
    completion = {
      autocomplete = ["TextChanged"];
      keywordLength = 1;
      completeopt = "menu,menuone";
    };
    # sources = [
    #   {name = "nvim_lsp";}
    #   {name = "nvim_lua";}
    #   {name = "path";}
    #   {name = "buffer";}
    # ];
    sources = [
      {
        name = "nvim_lsp";
        groupIndex = 1;
        priority = 3;
      }
      {
        name = "luasnip";
        groupIndex = 1;
        priority = 5;
        option = {
          show_autosnippets = true;
        };
      }
      {
        name = "path";
        groupIndex = 1;
      }
      {
        name = "buffer";
        groupIndex = 2;
        priority = 2;
      }
    ];

    window = {
      completion = {
        border = ["╭" "─" "╮" "│" "╯" "─" "╰" "│"];
        scrollbar = true;
      };
      documentation.border = ["╭" "─" "╮" "│" "╯" "─" "╰" "│"];
    };

    preselect = "Item";

    mapping = {
      "<Up>" = "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })";
      "<Down>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })";
      "<C-p>" = "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })";
      "<C-n>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })";
      "<C-k>" = "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })";
      "<C-j>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })";
      "<C-Space>" = {
        action = "cmp.mapping.complete()";
        modes = ["i" "c"];
      };
      "<CR>" = "cmp.mapping.confirm({ select = false })";

      "<C-l>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
    };
  };
}
