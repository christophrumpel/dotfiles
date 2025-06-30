#!/bin/bash

echo "Testing iTerm configuration..."

# Set up iTerm2 directories
ITERM_PROFILES_DIR="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
ITERM_COLORS_DIR="$HOME/Library/Application Support/iTerm2/DynamicColorPresets"
PROFILE_SOURCE="$HOME/.dotfiles/support/cr_iterm_profile.json"
COLORS_SOURCE="$HOME/.dotfiles/support/lovelace.itermcolors"

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

# Delete the default profile and set Christoph as default
defaults delete com.googlecode.iterm2 "New Bookmarks" 2>/dev/null || true
defaults write com.googlecode.iterm2 "Default Bookmark Guid" "D363B624-E4D1-4F61-B2F3-2E8749977E20"

echo "iTerm configuration complete. Please open iTerm to test."