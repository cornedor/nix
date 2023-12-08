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
    figma.figma-vscode-extension
    mxsdev.typescript-explorer
    bradlc.vscode-tailwindcss
    stivo.tailwind-fold
    astro-build.astro-vscode
    oven.bun-vscode
    formulahendry.auto-rename-tag
    # ziglang.vscode-zig
    jakebecker.elixir-ls
    rhaiscript.vscode-rhai
    murloccra4ler.leap
    vscodevim.vim
    golang.go
    ocamllabs.ocaml-platform

    chenglou92.rescript-vscode
    denoland.vscode-deno
    jnoortheen.nix-ide
    esbenp.prettier-vscode
    dbaeumer.vscode-eslint
    ms-azuretools.vscode-docker
    ms-vscode-remote.remote-ssh
    bmewburn.vscode-intelephense-client
    eamodio.gitlens
    redhat.vscode-yaml
    firefox-devtools.vscode-firefox-debug
    vscode-icons-team.vscode-icons
    editorconfig.editorconfig
    mikestead.dotenv
    arrterian.nix-env-selector
    denoland.vscode-deno
    
    # Java
    redhat.java
    vscjava.vscode-java-debug
    vscjava.vscode-java-pack
    vscjava.vscode-maven
    vscjava.vscode-java-dependency
    vscjava.vscode-gradle
  ];
  vscodeWithExtensions = pkgs.vscode-with-extensions.override {
    # vscode = pkgs.vscodium;
    vscodeExtensions = marketplace-extensions;
  };
in {
  home.packages = [vscodeWithExtensions];
}
