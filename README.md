# dotfiles

Luke's dotfiles provisioned with [`chezmoi`].

Install with:

```sh
git clone git@github.com:lkdm/dotfiles.git
chezmoi init --source=~/path/to/dotfiles
```

## Chezmoi info

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

## Usage

```sh
chezmoi apply
```

