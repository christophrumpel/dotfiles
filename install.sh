#!/bin/sh

echo "Setting up your Mac ❤️..."

# Check for Homebrew and install if we don't have it	
if test ! $(which brew); then	
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Update Homebrew recipes	
brew update

# Install all the dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew tap homebrew/cask-drivers
brew bundle --file $HOME/.dotfiles/Brewfile

# Create a Sites directories	
mkdir $HOME/Sites
mkdir $HOME/Sites/Tests	
mkdir $HOME/Sites/Packages	
mkdir $HOME/Sites/Forks

# Clone Github repositories	
./clone.sh

# Set macOS preferences	
# We will run this last because this will reload the shell	
source .macos
