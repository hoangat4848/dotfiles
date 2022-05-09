#!/bin/sh

# Install nix
sh < (curl -L https://nixos.org/nix/install) --no-daemon

# Source nix
. ~/.nix-profile/etc/profile.d/nix.sh

# Install packages
nix-env -iA \
	nixpkgs.zsh \
	nixpkgs.antibody \
	nixpkgs.git \
	nixpkgs.lazygit \
  nixpkgs.hub \
  nixpkgs.delta \
	nixpkgs.tmux \
	nixpkgs.stow \
	nixpkgs.yarn \
	nixpkgs.fzf \
	nixpkgs.ripgrep \
	nixpkgs.zoxide \
	nixpkgs.bat \
  nixpkgs.exa \
	nixpkgs.direnv

# stow every dirs
stow */

# add zsh to valid login shells
command -v zsh | sudo tee -a /etc/shells

# Change default shell to zsh.
sudo chsh -s $(which zsh) $USER
