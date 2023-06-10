{pkgs, ...}: let
  marketplace-extensions = with pkgs.vscode-marketplace; [
    codestream.codestream
    ms-playwright.playwright
    redhat.fabric8-analytics
    visualstudioexptteam.vscodeintellicode-completions
    visualstudioexptteam.vscodeintellicode
    ms-vsliveshare.vsliveshare
    orta.vscode-jest
    styled-components.vscode-styled-components
    asvetliakov.vscode-neovim
    ryanluker.vscode-coverage-gutters
    ms-vscode.live-server
    yoavbls.pretty-ts-errors
    rvest.vs-code-prettier-eslint
    xdebug.php-debug
    jock.svg
  ];
  vscodeWithExtensions = pkgs.vscode-with-extensions.override {
    # vscode = pkgs.vscodium;
    vscodeExtensions = with pkgs.vscode-extensions;
      [
        denoland.vscode-deno
        jnoortheen.nix-ide
        esbenp.prettier-vscode
        dbaeumer.vscode-eslint
        ms-azuretools.vscode-docker
        ms-vscode-remote.remote-ssh
        ms-toolsai.jupyter
        ms-python.python
        bmewburn.vscode-intelephense-client
        eamodio.gitlens
        chenglou92.rescript-vscode
        redhat.vscode-yaml
        firefox-devtools.vscode-firefox-debug
        vscode-icons-team.vscode-icons
        editorconfig.editorconfig
        mikestead.dotenv
        arrterian.nix-env-selector
      ]
      ++ marketplace-extensions;
  };
in {
  home.packages = [vscodeWithExtensions];
}
