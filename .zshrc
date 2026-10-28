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


# Herd injected PHP 8.5 configuration.
export HERD_PHP_85_INI_SCAN_DIR="/Users/christophrumpel/Library/Application Support/Herd/config/php/85/"


# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="/Users/christophrumpel/Library/Application Support/Herd/config/php/83/"


# Herd injected PHP 8.0 configuration.
export HERD_PHP_80_INI_SCAN_DIR="/Users/christophrumpel/Library/Application Support/Herd/config/php/80/"


# Herd injected PHP 8.2 configuration.
export HERD_PHP_82_INI_SCAN_DIR="/Users/christophrumpel/Library/Application Support/Herd/config/php/82/"


# Herd injected PHP 7.4 configuration.
export HERD_PHP_74_INI_SCAN_DIR="/Users/christophrumpel/Library/Application Support/Herd/config/php/74/"


# Herd injected PHP 8.1 configuration.
export HERD_PHP_81_INI_SCAN_DIR="/Users/christophrumpel/Library/Application Support/Herd/config/php/81/"

# opencode
export PATH=/Users/christophrumpel/.opencode/bin:$PATH
fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit


# Herd injected PHP 8.6 configuration.
export HERD_PHP_86_INI_SCAN_DIR="/Users/christophrumpel/Library/Application Support/Herd/config/php/86"
