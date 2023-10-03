# dotfiles

1. Install Apple's Commandline Tools, which is a prerequisite for using Git and Homebrew.

```
xcode-select --install
```

2. Clone the repository

```
git clone git@github.com:lkdm/dotfiles.git ~/.dotfiles
```

3. Run the setup script.

```
~/.dotfiles/setup.sh
```

3. Choose a Brewfile to load

Personal

```
brew bundle --file ~/.dotfiles/brewfile/personal
```

Work

```
brew bundle --file ~/.dotfiles/brewfile/work
```