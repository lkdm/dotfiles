# dotfiles

Luke's dotfiles provisioned with [`chezmoi`], and are designed to be;

- **Cross-platform**: These dotfiles work on macOS and Linux.
- **Declarative**: Upon `apply`, relevant packages are installed and configured.
- **Performant**: [Uses ZSH without OMZ, Starship, and caches evaluations using
Chezmoi](https://lukm.dev/shell/speed-up-zsh/).
- **Shell-agnostic**: Sets environment variables in `~/.profile` for login and
non-login shells.

Install with:

```sh
git clone git@github.com:lkdm/dotfiles.git
chezmoi init --source=~/path/to/dotfiles
```

## Chezmoi

Chezmoi is a CLI tool that patches dotfiles from a Git repository.

**Features**

- **Patching**: On `apply`, patches files from repo onto system (ie.
`dot_bashrc` -> `~/.bashrc`)
- **Executable files**: Files prefixed with `executable_` are made executable.
- **One-time runs**: Files prefixed with `run_once_` executes only once on
`init`.
- **Run scripts**: Files prefixed with `run_` are executed on each `apply`
- **Templates**: Files ending with `.tmpl` are rendered on `apply` using Go
templating syntax.

**Usage**

```sh
chezmoi apply
```

## Applications & tools

- **GhosTTY**: Default terminal emulator
- **Homebrew**: Package manager on both macOS and Linux
- **1Password**: For secure secrets management
- **Tmux**: Terminal multiplexer
- **Neovim**: IDE/editor
- **Atuin**: Shell history syncronisation and fuzzy search
- **LazyGit**: TUI Git client
