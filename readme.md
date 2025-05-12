# Christoph Rumpel's Dotfiles

This is a fork from [Dries Vints](https://github.com/driesvints/dotfiles)'s dotfiles. Check out his detailed documentation about all the files. I just changed a few things to better fit my needs.

Be careful when using these dotfiles because they change a lot of MacOS settings and install all the apps I need.

## Backup Checklist

- Did you commit and push any changes/branches to your git repositories?
- Did you copy your .env files to a safe place if they are not casual?
- Did you backup your IDE settings? (e.g. PhpStorm)
- Did you backup local databases you need?
- Did you remember to save all important documents from non-cloud directories?
- Did you save all of your work from apps which aren't synced through cloud?

## Installation

1. `Update macOS` to the latest version with the App Store
2. `Create new SSH keys` or copy given ones to `SSH keys to ~/.ssh` and make sure they're set to 600
```zsh
   curl https://raw.githubusercontent.com/christophrumpel/dotfiles/master/ssh.sh | sh -s "christoph@christoph-rumpel.com"
   ```
3. `Sign to 1Password` and add new SSH keys to GitHub (for loading private repos)
4. `Clone dotfiles` to ~/.dotfiles (you will be asked to download command line tools)
    ```zsh
    git clone https://github.com/christophrumpel/dotfiles.git ~/.dotfiles
    ```
5. `Run Installation` script
    ```zsh
    ~/.dotfiles/install.sh
    ```
6. `Log in to Dropbox` and sync folders
7. `Restart your computer` to finalize  the process


## Additional Steps

- Install apps manually
    - Davinci Resolve
    - Pixelmator Pro Demo (Dropbox/Backups)
- Custom Settings
    - Copy ssh config from 1Password to `~/.ssh/config`
    - PhpStorm: enable repository sync `https://github.com/christophrumpel/phpstorm-settings`
- Set Permissions
    - Bartender

## Still Missing

- Activate right mouse click
- Sleep time missmatch/error
- Operator Mono font
- Disable Mac sounds
