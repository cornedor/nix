{
  plugins.neo-tree = {
    enable = true;
    popupBorderStyle = "rounded";
    sources = ["filesystem" "buffers" "git_status" "document_symbols"];
    sourceSelector = {
      winbar = true;
    };
    closeIfLastWindow = true;
  };
  extraConfigLua = ''
    require("which-key").register({
      e = {
        "<cmd>Neotree toggle<cr>",
        "Toggle Neotree"
      },
    }, {
      prefix = "<leader>",
    })

    -- vim.cmd([[highlight NeoTreeNormalNC ctermbg=0 guibg=#eee8d5]])
    -- vim.cmd([[highlight NeoTreeNormal ctermbg=0 guibg=#eee8d5]])
  '';
}
