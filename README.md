# dotfiles

Luke's dotfiles provisioned with [`chezmoi`], and are designed to be;

- **Cross-platform**: These dotfiles work on macOS and various Linux
distributions.
- **Declarative**: Upon `apply`, relevant packages are installed and configured.
- **Secure**: 1Password is used for SSH secrets
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
- **Zellij**: Terminal multiplexer
- **Neovim**: IDE/editor
- **Distrobox**: Supports seamless use inside Fedora Atomic distributions
- **Atuin**: Shell history syncronisation and fuzzy search
- **LazyGit**: TUI Git client

## Distrobox usage

Inside of a Distrobox, this will;

- Use the host's Docker socket
- Use the host's 1Password socket
- Create the alias `host` to open a shell or execute code on the host.
- Uses common-sense to alias some commands to the host; `flatpak`, and `ujust`
should really never be run inside my Debian dev containers, for example.

The result is that when on a Fedora Atomic distro, such as Bluefin, I seamlessly live out
of my Debian Distrobox.

## Philosophy

My dotfiles manage system configuration as code that can be declaratively and idempotently reapplied. They avoid unnecessary tools and complex frameworks to keep the setup minimal and non-invasive. Designed to be portable and cross-platform, they work smoothly across different operating systems, shells, and environments. Secrets are securely stored using 1Password, ensuring security by design. The configuration is performance-focussed, optimising shell startup and runtime by minimising overhead.
