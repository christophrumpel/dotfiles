#-----------------------------------------------------------------------------------#
#	*START* Base
#-----------------------------------------------------------------------------------#

# Reload bash
alias reload_bash=". ~/.dotfiles/.zshrc"

# Be gentle
alias please="sudo"

#-----------------------------------------------------------------------------------#
#	*END* Base
#-----------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------#
#	*START* Navigation
#-----------------------------------------------------------------------------------#

# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

#-----------------------------------------------------------------------------------#
#	*END* Navigation
#-----------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------#
#	*START* GOTO
#-----------------------------------------------------------------------------------#

alias home="cd ~/"
alias gotodotfiles="cd ~/.dotfiles"
alias gotosites="cd ~/Sites"
alias gototests="cd ~/Sites/Tests"
alias gotojarvy="cd ~/Sites/jarvy"
alias gotodemos="cd ~/Sites/demos"

#-----------------------------------------------------------------------------------#
#	*END* GOTO
#-----------------------------------------------------------------------------------#

#-----------------------------------------------------------------------------------#
#	*START* GIT
#-----------------------------------------------------------------------------------#
alias g='git'
alias gs='git status'
alias nope="git reset --hard && git clean -df"
alias gaa='git add --all'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

alias gac="git add -A && git commit -m"
alias gpc="git push origin HEAD"


gsa ()
{
	git reset $(git commit-tree HEAD^{tree} -m \"${1:-A new start}\");
}

# Create a new private GitHub repo from the current local git project and push it
# Usage: gh-new-private my-repo-name
function gh-new-private() {
	local repo_name="$1"
	local repo_url

	if [ -z "$repo_name" ]; then
		echo "Usage: gh-new-private <repo-name>"
		return 1
	fi

	if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		echo "Not inside a git repository."
		return 1
	fi

	gh repo create "christophrumpel/$repo_name" --private --source=. --push || return 1

	repo_url="https://github.com/christophrumpel/$repo_name"
	echo "Repo created: $repo_url"
}

# Invite jarvy-cr to the current GitHub repo with push access
# Usage: gh-add-jarvy
function gh-add-jarvy() {
	local remote_url repo_slug

	if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		echo "Not inside a git repository."
		return 1
	fi

	remote_url=$(git remote get-url origin 2>/dev/null)

	if [ -z "$remote_url" ]; then
		echo "No origin remote found."
		return 1
	fi

	repo_slug=$(echo "$remote_url" | sed -E 's#(git@github.com:|https://github.com/)##' | sed -E 's#\.git$##')

	if [ -z "$repo_slug" ]; then
		echo "Could not detect GitHub repo from origin remote."
		return 1
	fi

	gh api \
		-X PUT \
		"repos/$repo_slug/collaborators/jarvy-cr" \
		-f permission=push

	echo "Invited jarvy-cr to $repo_slug with push access."
}

#-----------------------------------------------------------------------------------#
#	*END* GIT
#-----------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------#
#	*START* PHP
#-----------------------------------------------------------------------------------#

alias art='php artisan'
alias artv='php artisan --version'
alias mfs='php artisan migrate:fresh --seed'
alias artclearall='php artisan cache:clear && php artisan view:clear && php artisan config:clear'
alias phpunit='vendor/bin/phpunit'
alias clearlog='truncate -s 0 $PWD/storage/logs/laravel.log'
alias clearlogs='truncate -s 0 $PWD/storage/logs/*.log'


#-----------------------------------------------------------------------------------#
#	*END* PHP
#-----------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------#
#	*START* HERD
#-----------------------------------------------------------------------------------#

# Share a local Herd site publicly via a Cloudflare quick tunnel
# Usage: share (uses current folder name) or share my-site
function share() {
	local host="${1:-$(basename "$PWD")}.test"

	if [[ $(curl -s -o /dev/null -w '%{redirect_url}' "http://$host") == https://* ]]; then
		# Site is secured with Herd (https)
		cloudflared tunnel --url "https://$host" --http-host-header "$host" \
			--origin-server-name "$host" --no-tls-verify
	else
		cloudflared tunnel --url "http://$host" --http-host-header "$host"
	fi
}

#-----------------------------------------------------------------------------------#
#	*END* HERD
#-----------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------#
#	*START* HOSTS
#-----------------------------------------------------------------------------------#

alias hosts='sudo subl /etc/hosts'
alias vhosts='sudo subl /etc/apache2/extra/httpd-vhosts.conf'

#-----------------------------------------------------------------------------------#
#	*END* HOSTS
#-----------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------#
#	*START* NETWORK
#-----------------------------------------------------------------------------------#

# IP addresses
alias ip_intern="ipconfig getifaddr en0"
alias ip_extern="curl ipecho.net/plain; echo"


# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

#-----------------------------------------------------------------------------------#
#	*END* NETWORK
#-----------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------#
#	*START* Seach & List
#-----------------------------------------------------------------------------------#

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
else # OS X `ls`
	colorflag="-G"
fi

# List all files colorized in long format
alias l="ls -laF"

# List all files colorized in long format, including dot files
alias la="ls -la ${colorflag}"


# List only directories
alias lsd='ls -l | grep "^d"'

# Always use color output for `ls`
if [[ "$OSTYPE" =~ ^darwin ]]; then
	alias ls="command ls -G"
else
	alias ls="command ls --color"
	export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
fi


#-----------------------------------------------------------------------------------#
#	*END* Search & List
#-----------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------#
#	*START* FILE HANDLING
#-----------------------------------------------------------------------------------#

# File size
alias fs="stat -f \"%z bytes\""

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"


nd ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

#-----------------------------------------------------------------------------------#
#	*END* FILE HANDLING
#-----------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------#
#	*START* SPECIALS
#-----------------------------------------------------------------------------------#

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

#-----------------------------------------------------------------------------------#
#	*END* SPECIALS
#-----------------------------------------------------------------------------------#
