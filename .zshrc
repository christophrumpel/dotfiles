# Initialize Starship
eval "$(starship init zsh)"

# Set custom Starship config file
export STARSHIP_CONFIG=$HOME/.dotfiles/starship.toml

# Load PATH configurations
source ~/.dotfiles/path.zsh

# Load aliases
source ~/.dotfiles/aliases.zsh


# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="/Users/christophrumpel/Library/Application Support/Herd/config/php/84/"


# Herd injected NVM configuration
export NVM_DIR="/Users/christophrumpel/Library/Application Support/Herd/config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -f "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh" ]] && builtin source "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh"

# Herd injected PHP binary.
export PATH="/Users/christophrumpel/Library/Application Support/Herd/bin/":$PATH
