{ pkgs, lib, ... }:
let
  vscodeWithExtensions = pkgs.vscode-with-extensions.override {
    # vscode = pkgs.vscodium;
    vscodeExtensions = with pkgs.vscode-extensions; [
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
    ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "codestream";
        publisher = "CodeStream";
        version = "14.19.0";
        sha256 = "sha256-l+xJHj/j4niMnLDsPNwRjaBU0rZDJ9nEqBDHpmCnC5o=";
      }
      {
        name = "playwright";
        publisher = "ms-playwright";
        version = "1.0.11";
        sha256 = "sha256-pTU+C7nwbE6QMRjQUWz37+07YK+2hhPKLIInyJ+1W9g=";
      }
      {
        name = "fabric8-analytics";
        publisher = "redhat";
        version = "0.3.6";
        sha256 = "sha256-2A27gGpcoCV4Hr1c+QhKwclHxBKjI/izuaE7pvL2pxk=";
      }
      {
        name = "vscodeintellicode-completions";
        publisher = "VisualStudioExptTeam";
        version = "1.0.22";
        sha256 = "sha256-62b0O+1rSaA2ZSmzEqdpEb7c9XYPWmHNV7W+7HAC5cg=";
      }
      {
        name = "vscodeintellicode";
        publisher = "VisualStudioExptTeam";
        version = "1.2.30";
        sha256 = "sha256-f2Gn+W0QHN8jD5aCG+P93Y+JDr/vs2ldGL7uQwBK4lE=";
      }
      # Extension from repo not supported on x86_64-darwin
      {
        name = "vsliveshare";
        publisher = "MS-vsliveshare";
        version = "1.0.5864";
        sha256 = "sha256-UdI9iRvI/BaZj8ihFBCTFJGLZXxS3CtmoDw8JBPbzLY=";
      }
      {
        name = "vscode-jest";
        publisher = "Orta";
        version = "5.2.3";
        sha256 = "sha256-cPHwBO7dI44BZJwTPtLR7bfdBcLjaEcyLVvl2Qq+BgE=";
      }
      {
        name = "vscode-styled-components";
        publisher = "styled-components";
        version = "1.7.8";
        sha256 = "sha256-VoLAjBcAizTxd+BHwXoNSlSxqXno3PjVxaickLCtnsw=";
      }
      #{
      #  name = "vscode-neovim";
      #  publisher = "asvetliakov";
      #  version = "0.0.97";
      #  sha256 = "sha256-rNGW8WB3jBSjThiB0j4/ORKMRAaxFiMiBfaa+dbGu/w=";
      #}
      {
        name = "vscode-coverage-gutters";
        publisher = "ryanluker";
        version = "2.10.4";
        sha256 = "sha256-T9+LyyPtg8u7OMOjwKimgiWS8kHqu8SXgSlrBtDRHwY=";
      }
      {
        name = "live-server";
        publisher = "ms-vscode";
        version = "0.5.2023051501";
        sha256 = "sha256-BW3AI1723yvBF4jd3qzVS5J+xrojSzuV7b4kTDkpnqI=";
      }
      {
        name = "pretty-ts-errors";
        publisher = "yoavbls";
        version = "0.4.1";
        sha256 = "sha256-vY/dVO9k3LcXLYH9eX9blKMB+mDGCWkmU9ZU62YvAcM=";
      }
      {
        name = "vs-code-prettier-eslint";
        publisher = "rvest";
        version = "5.1.0";
        sha256 = "sha256-nOwmLjAmjElX+IAoxVBHlXEowM/GmlabwGd8KqGxB14=";
      }
      {
        name = "php-debug";
        publisher = "xdebug";
        version = "1.32.1";
        sha256 = "sha256-MfuHldCigjuJ9ONE1QDZwlkFo2gKfU6KAinIru5M4fs=";
      }
    ];
  };
in
{
  home.packages = [ vscodeWithExtensions ];
}
