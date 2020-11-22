#!/bin/sh
# Pre project generation script

which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    brew update
fi

# Homebrew dependencies
brew bundle --file .github/brew/Brewfile

pkill Xcode

# Run linters and formatters
if [[ -f ".swiftformat" ]]; then
    swiftformat .
fi

if [[ -f ".swiftlint" ]]; then
    swiftlint autocorrect
fi

if [[ -f "swiftgen.yml" ]]; then
    swiftgen
fi

# Update carthage dependencies
if [[ -f "Cartfile" ]]; then
    carthage update --cache-builds --platform iOS
fi

# Upgrade cocoapods
if [[ -f "Podfile" ]]; then
    pod install
fi