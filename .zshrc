
# Oh-My-Posh
# TODO: Move to zinit
# /home/ubuntu/.local/bin
# /home/ubuntu/.cache/oh-my-posh/themes
PATH=$PATH:/home/ubuntu/.local/bin
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
# Refresh with $ exec zsh

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit, if not present
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
# OZMP => https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::azure
zinit snippet OMZP::kubectl
zinit snippet OMZP::helm
zinit snippet OMZP::terraform
zinit snippet OMZP::command-not-found
zinit snippet OMZP::ssh-agent

# May not be required with zinit?
# autoload -U compinit && compinit

zinit cdreplay -q # Replay cached completions

# Bindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Aliases
alias ls='ls --color'

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' id_ed25519
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no # Works with fzf-tab
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle :omz:plugins:ssh-agent identities id_ed25519
zstyle :omz:plugins:ssh-agent lazy yes
zstyle :omz:plugins:ssh-agent agent-forwarding yes

# Shell integrations
# FZF_VERSION=$(curl -s "https://api.github.com/repos/junegunn/fzf/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
# wget -qO fzf.tar.gz https://github.com/junegunn/fzf/releases/latest/download/fzf-$FZF_VERSION-linux_amd64.tar.gz
# sudo tar xf fzf.tar.gz -C /usr/local/bin
# fzf --version
# rm -rf fzf.tar.gz
source <(fzf --zsh) # Requires $ apt install fzf
