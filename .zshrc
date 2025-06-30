# Initialize Starship
eval "$(starship init zsh)"

# Set custom Starship config file
export STARSHIP_CONFIG=$HOME/.dotfiles/starship.toml

# Load PATH configurations
source ~/.dotfiles/path.zsh

# Load aliases
source ~/.dotfiles/aliases.zsh
