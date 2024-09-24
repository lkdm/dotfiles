# Finder: Show hidden files
defaults write com.apple.Finder AppleShowAllFiles true
killall Finder

# Disable press and hold for keys in VSCode
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
