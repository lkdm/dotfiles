# dotfiles

Luke's dotfiles provisioned with [`chezmoi`], and are designed to be;

- **Cross-platform**: These dotfiles work on macOS and Linux.
- **Declarative**: Upon `apply`, relevant packages are installed and configured.
- **Performant**: [Uses ZSH without OMZ, Starship, and caches evaluations using
Chezmoi](https://lukm.dev/shell/speed-up-zsh/).
- **Shell-agnostic**: Sets environment variables in `~/.profile` for login and
non-login shells.

## Setup

```sh
mkdir -p ~/Repos/lkdm
```

First, clone the repository or download it and put it in the correct location:

```sh
cd ~/Repos/lkdm
git clone git@github.com:lkdm/dotfiles.git
```

Rename `example_chezmoi.toml` to `.chezmoi.toml`, fill it in, then initiate chezmoi:

```sh
chezmoi init --source=~/path/to/dotfiles
```

Run chezmoi apply:

```sh
chezmoi apply
```
