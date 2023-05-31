# Nix config

Setup based on https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050

```
nix build .#darwinConfigurations.corne.system
./result/sw/bin/darwin-rebuild switch --flake ".#corne"
```

