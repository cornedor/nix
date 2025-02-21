{
  pkgs,
  config,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "Corné Dorrestijn";
    userEmail = "contact@corne.info";
    extraConfig = {
      core = {
        editor = "vim";
      };
      color.ui = true;
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
    };
    signing = {
      key = "E35CCCA771A37255A87F21B1E01A9819F86CE169";
      signByDefault = true;
    };
    ignores = [
      ".DS_Store"
      ".envrc"
    ];

    difftastic.enable = true;

    includes = [
      {
        condition = "hasconfig:remote.*.url:git@git.emico.io:*/**";
        contents = {
          user = {
            email = "cdorrestijn@emico.nl";
            name = "Corné Dorrestijn";
          };
        };
      }
    ];
  };
}
