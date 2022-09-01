# zsh
# Exports
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

## Auto complete
autoload -Uz compinit
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
HISTSIZE=10000
HISTFILESIZE=10000
SAVEHIST=10000
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

autoload -Uz +X bashcompinit && bashcompinit
    
# vim
export XDG_CONFIG_HOME="$HOME/.config"

# fzf
# export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    
# direnv
# eval "$(direnv hook zsh)"

# OS別
case $(uname | tr '[:upper:]' '[:lower:]') in
  linux*)

    # asdf
    . $HOME/.asdf/asdf.sh
    . ~/.asdf/plugins/java/set-java-home.zsh

    ## Android
    export ANDROID_HOME="$HOME/Android/sdk"
    export ANDROID_SDK_ROOT="$HOME/Android/sdk"
    export PATH=$ANDROID_HOME/platform-tools:$PATH 
    export PATH=$ANDROID_HOME/tools:$PATH
    export PATH=$ANDROID_HOME/tools/bin:$PATH
    export PATH=$ANDROID_HOME/emulator:$PATH
    export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH

    ## Flutter
    export PATH="$PATH":"$HOME/.pub-cache/bin"
    ;;
  darwin*)
    # HomeBrew
    # eval "$(/opt/homebrew/bin/brew shellenv)"
    export HOMEBREW_PREFIX="/opt/homebrew";
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
    export HOMEBREW_REPOSITORY="/opt/homebrew";
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

    # asdf
    # . $(brew --prefix asdf)/asdf.sh
    . /opt/homebrew/opt/asdf/asdf.sh
    # . ~/.asdf/plugins/java/set-java-home.zsh
    export JAVA_HOME=$(/usr/libexec/java_home)
    export JDK_HOME=${JAVA_HOME}
    
    ## Android
    export ANDROID_HOME="$HOME/Library/Android/sdk"
    export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
    export PATH=$ANDROID_HOME/platform-tools:$PATH 
    export PATH=$ANDROID_HOME/tools:$PATH
    export PATH=$ANDROID_HOME/tools/bin:$PATH
    export PATH=$ANDROID_HOME/emulator:$PATH
    export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH
    
    ## Flutter
    export PATH="$PATH":"$HOME/.pub-cache/bin"
    
    ## Clang/LLVM
    # export LLVM_PATH="$(brew --prefix llvm)"
    export LLVM_PATH="/opt/homebrew/opt/llvm"
    export PATH="$LLVM_PATH/bin:${PATH}"
    
    export LDFLAGS="-L$LLVM_PATH/lib"
    export CPPFLAGS="-I$LLVM_PATH/include"
    ;;
  *)
esac

## GCP
export PATH=$HOME/google-cloud-sdk/bin:$PATH
    
## Fastlane
export PATH=$HOME/.fastlane/bin:$PATH
    
## Yarn
export PATH="$(yarn global bin):$PATH"
        
## Rust
export PATH=$HOME/.cargo/bin:$PATH

## Go
export GOPATH=$HOME/.go
export GOROOT=$( go env GOROOT )
export GOBIN=$GOROOT/bin
export PATH=$GOBIN:$PATH

## Aliases
alias vi='nvim'
alias vim='nvim'
alias neovim='nvim'
alias c="clear"
alias ll='ls -laF'
alias .="cd .."
alias ..="cd ../.."
alias ...="cd ../../.."
alias ....="cd ../../../.."
alias .....="cd ../../../../.."
alias reload='exec -l $SHELL;source ~/.zshrc'
alias emu='emulator @$(emulator -list-avds | peco)'
alias emu-ls='avdmanager list avd'
alias simu='open -a Simulator'
alias simu-ls='xcrun simctl list'
