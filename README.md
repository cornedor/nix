# Nix config

Setup based on https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050

## Darwin

```
nix build .#darwinConfigurations.corne.system
./result/sw/bin/darwin-rebuild switch --flake ".#corne"
```

## Linux

```
sudo nixos-rebuild switch --flake .
```

## Formatting

```
, alejandra .
```

## Updates

```
nix flake update
```

## TODO

- [ ] Add vscode configuration
- [ ] Add vim configuration
- [ ] Move GPU passtrough config to this repo
