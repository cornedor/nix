#!/bin/zsh

pushd /Users/corne/.config/nix
nix build .#darwinConfigurations.corne.system && ./result/sw/bin/darwin-rebuild switch --flake ".#corne"
popd
