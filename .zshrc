# zsh

## Auto complete
autoload -U compinit
compinit
zstyle ':completion:*' list-colors di=34 fi=0
zstyle ':completion:*:default' menu select=1
setopt PRINT_EIGHT_BIT

## Prompt
## https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
PROMPT='%(?.%F{yellow}%#.%F{red}%#)%f '
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}%b%f'
zstyle ':vcs_info:*' enable git

## Save command history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
HISTFILESIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# HomeBrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# vim
export XDG_CONFIG_HOME="$HOME/.config"

# fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Exports
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

# asdf
# cat ~/.asdfrc
. $(brew --prefix asdf)/asdf.sh
. ~/.asdf/plugins/java/set-java-home.zsh

## Android
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/tools/bin:$PATH
export PATH=$ANDROID_HOME/emulator:$PATH
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH

## Go
export GOPATH=$HOME/.go
export GOROOT=$( go env GOROOT )
export GOBIN=$GOROOT/bin
export PATH=$GOBIN:$PATH

# direnv
eval "$(direnv hook zsh)"

## Flutter
#export PATH="$PATH:/Applications/flutter/bin"
export PATH="$PATH":"$HOME/.pub-cache/bin"

## GCP
export PATH=$HOME/google-cloud-sdk/bin:$PATH

## Fastlane
export PATH=$HOME/.fastlane/bin:$PATH

## Yarn
export PATH="$(yarn global bin):$PATH"

## Ruby
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init - zsh)"

## Rust
export PATH=$HOME/.cargo/bin:$PATH

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/Cellar/go/1.15.2/libexec/bin/bitcomplete bit

## Aliases
alias vi='nvim'
alias vim='nvim'
alias c="clear"
alias ll='ls -laF'
alias .="cd .."
alias ..="cd ../.."
alias ...="cd ../../.."
alias ....="cd ../../../.."
alias .....="cd ../../../../.."

