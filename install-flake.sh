#!/bin/zsh

pushd /Users/corne/.config/nix
nix build --impure .#darwinConfigurations.corne.system &&
echo "Build complete, installing..." &&
./result/sw/bin/darwin-rebuild switch --impure --flake ".#corne"
popd
