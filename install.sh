#!/bin/sh

echo "Setting up your Mac ❤️..."

# Ask for the administrator password upfront
echo "We need your password for some installation steps..."
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew and install if we don't have it
echo "Installing Homebrew..."
if test ! $(which brew); then	
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install Starship
echo "Installing Starship..."
if command -v starship &> /dev/null; then
    echo "Starship is already installed"
else
    # Create /usr/local/bin if it doesn't exist
    echo "Creating /usr/local/bin directory..."
    sudo mkdir -p /usr/local/bin

    # Install Starship
    if curl -sS https://starship.rs/install.sh | sh; then
        echo "Starship installed successfully"
    else
        echo "Failed to install Starship" >&2
        exit 1
    fi
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Update Homebrew recipes	
brew update

# Install all the dependencies with bundle (See Brewfile)
echo "Installing Homebrew packages..."
brew bundle --file $HOME/.dotfiles/Brewfile

# Set up iTerm2 profile
ITERM_PROFILES_DIR="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
PROFILE_SOURCE="$HOME/.dotfiles/support/cr_iterm_profile.json"
PROFILE_DEST="$ITERM_PROFILES_DIR/cr_iterm_profile.json"

if [ ! -d "$ITERM_PROFILES_DIR" ]; then
    echo "Creating iTerm2 Dynamic Profiles directory..."
    mkdir -p "$ITERM_PROFILES_DIR"
fi

if [ -f "$PROFILE_SOURCE" ]; then
    echo "Installing iTerm2 profile..."
    # Wrap the profile content in the required format
    echo "{\"Profiles\": [$(cat "$PROFILE_SOURCE")]}" > "$PROFILE_DEST"
else
    echo "Warning: iTerm2 profile not found at $PROFILE_SOURCE"
fi


# Create a Sites directories	
mkdir $HOME/Sites
mkdir $HOME/Sites/Tests	
mkdir $HOME/Sites/Packages	
mkdir $HOME/Sites/Forks

# Set macOS preferences	
# We will run this last because this will reload the shell	
source $HOME/.dotfiles/.macos
