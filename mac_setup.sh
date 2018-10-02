defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false
sudo nvram SystemAudioVolume=" "
sudo pmset -a standbydelay 86400
defaults write com.apple.universalaccess reduceTransparency -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
sudo pmset -a hibernatemode 0
sudo pmset -a sms 0
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write com.apple.BezelServices kDim -bool true
defaults write com.apple.BezelServices kDimTime -int 300
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.finder QuitMenuItem -bool true
defaults write com.apple.Finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true
defaults write com.apple.finder WarnOnEmptyTrash -bool false
defaults write com.apple.finder EmptyTrashSecurely -bool true
chflags nohidden ~/Library
sudo chflags nohidden /Volumes
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock autohide -bool true
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.terminal SecureKeyboardEntry -bool true
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
defaults write com.apple.ActivityMonitor IconType -int 5
defaults write com.apple.ActivityMonitor ShowCategory -int 0
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Make dock hide and show instantly
defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock
