# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH. export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# create a global per-pane variable that holds the pane's PWD
export PS1=$PS1'$( [ -n $TMUX ] && tmux setenv -g TMUX_PWD_$(tmux display -p "#D" | tr -d %) $PWD)'

export EDITOR="/opt/homebrew/bin/nvim"
export PATH="/Users/atishayamaharjan/.local/bin:$PATH"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
export MANPAGER="bat"
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# Git commit while ignoring whitespaces
alias addwn='git diff -U0 -w --no-color --src-prefix=a/ --dst-prefix=b/ "$@" | git apply --cached --ignore-whitespace --unidiff-zero'

if type ag &>/dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi
#refer rg over ag
if type rg &>/dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi

alias aviary='ssh maharjaa@aviary.cs.umanitoba.ca'

# Git add or restore only a specified file
gfc() {
    if [[ "$1" == "--restore" ]]; then
        shift
        git restore --staged "$(git diff --staged --name-only | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')"
    else
        git add "$(git diff-index --name-only HEAD | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')"
    fi
}

# [G]it [C]heckout [B]ranch :- Git checkout with branches but with fzf:
alias gcb='git checkout $(git branch | fzf)'

# [L]int [A]dded [F]iles
laf() {
    local changed_files=$(git diff-index --name-only HEAD)

    local files_array=()

    while IFS= read -r file; do
        eslint "$file" --fix
    done <<<"$changed_files"
}

alias sd='cd "$(fd -u --type d --exclude node_modules --color=auto | fzf)"'
alias sdr='cd ~ && cd "$(fd -u --type d --exclude node_modules --color=auto | fzf)"'
alias sf='nvim "$(fd -u --type f --exclude node_modules --color=auto | fzf)"'
alias sfr='cd ~ && nvim "$(fd -u --type f --exclude node_modules --color=auto | fzf)"'
alias sdnvim='sd && nvim'

# Create a react directory
alias crd='~/bin/crd.sh'

# Change extension
alias ce='~/bin/ce.sh'

# Make LaTeX file with template
alias mlf='~/bin/mlf.sh'

cdotsvg() {
    dot -Tsvg "$1" >>"$1.svg"
}

# pnpm
export PNPM_HOME="/Users/atishayamaharjan/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /Users/atishayamaharjan/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

. "$HOME/.local/bin/env"
export PATH="/Users/atishayamaharjan/.pixi/bin:$PATH"
