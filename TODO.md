# Bug: XDG_HOME_CONFIG broken on mac

$XDG_HOME_CONFIG is not ~/.config on Mac, and this breaks most applications

# Mise

- [ ] Try mise-en-place
- [ ] Replace NVM with mise, or https://github.com/Schniz/fnm

# Mac OS management command

- [ ] Create management command for Mac
  - [ ] Appearance setter;
    - Set appearance to dark
      `defaults write -g NSRequiresAquaSystemAppearance -bool true`
    - Set appearance to auto;
      `defaults write -g AppleInterfaceStyleSwitchesAutomatically -bool true`
