# dotfiles

Luke's dotfiles managed with [`chezmoi`].

Install with:

```sh
git clone git@github.com:lkdm/dotfiles.git
chezmoi init --source=~/path/to/repo
```

1Password information

```sh

```

## Chezmoi info

Chezmoi is a commandline tool to manage dotfiles and dotdirectories from a git repository

Chezmoi will:

- On apply, patch the contents of this repository onto parts of the host system. For example, `dot_bashrc` will be patched to `~/.bashrc`
- On apply, chmod files marked `executable_*` as `+x`
- On init, mark any files marked with `run_once`
- On apply, run any files marked `run_`.
- On apply, turn `.sh.tmpl` files into `.sh` files.

- Patching: On apply, Chezmoi patches the contents of the repository onto specific parts of the host system. For example, `dot_bashrc` in the repository becomes `~/.bashrc` on the host.
- Executable Marking: Files prefixed with `executable_[scriptname]` are automatically marked as executable (chmod +x) during the apply process.
- One-time Execution: Files marked with `run_once_` are executed only once during the initial init command.
- Script Execution: Any files prefixed with `run_` are executed when the apply command is run.
- Template Processing: Files with the `.[suffix].tmpl` extension are processed into `.sh` files during the apply command.

## Usage

Shows the difference in the output dotfiles after `chezmoi` patches

```sh
chezmoi diff
```

Apply changes to the host system

```sh
chezmoi apply
```
