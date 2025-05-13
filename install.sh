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

# Setup iTerm
echo "Setting up iTerm..."

# Disable "Last login" message
[ ! -f ~/.hushlogin ] && touch ~/.hushlogin

# Set up iTerm2 directories
ITERM_PROFILES_DIR="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
ITERM_COLORS_DIR="$HOME/Library/Application Support/iTerm2/DynamicColorPresets"
PROFILE_SOURCE="$HOME/.dotfiles/support/cr_iterm_profile.json"
COLORS_SOURCE="$HOME/.dotfiles/support/cr_iterm_colors.itermcolors"

# Create directories if they don't exist
mkdir -p "$ITERM_PROFILES_DIR"
mkdir -p "$ITERM_COLORS_DIR"

# Install profile
if [ -f "$PROFILE_SOURCE" ]; then
    echo "Installing iTerm2 profile..."
    echo "{\"Profiles\": [$(cat "$PROFILE_SOURCE")]}" > "$ITERM_PROFILES_DIR/cr_iterm_profile.json"
else
    echo "Warning: iTerm2 profile not found at $PROFILE_SOURCE"
fi

# Install color preset
if [ -f "$COLORS_SOURCE" ]; then
    echo "Installing iTerm2 color preset..."
    cp "$COLORS_SOURCE" "$ITERM_COLORS_DIR/"
else
    echo "Warning: iTerm2 color preset not found at $COLORS_SOURCE"
fi

# Margins
defaults write com.googlecode.iterm2 TerminalMargin -int 50
defaults write com.googlecode.iterm2 TerminalVMargin -int 20

# Set to minimal appearance theme
defaults write com.googlecode.iterm2 TabStyleWithAutomaticOption -int 5

# Create a Sites directories	
mkdir $HOME/Sites
mkdir $HOME/Sites/Tests	
mkdir $HOME/Sites/Packages	
mkdir $HOME/Sites/Forks

# Set macOS preferences	
# We will run this last because this will reload the shell	
source $HOME/.dotfiles/.macos
