# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"
#ZSH_THEME="powerline"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias igit="git --no-pager"
alias info="info --vi-keys"
alias mkdir="mkdir -p -v"
alias trsh="mv --target-directory=$HOME/trash"
alias vi="nvim"
alias gt="gnome-terminal"

alias pastebin="/google/src/head/depot/eng/tools/pastebin"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
    vi-mode
    git
    fasd
    colored-man-pages
    common-aliases
    last-working-dir
    history-substring-search
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
export KEYTIMEOUT=1

# colors for ls
if [[ -f ~/.dir_colors ]] ; then
    eval $(dircolors -b ~/.dir_colors)
fi

PATH=$PATH:~/depot_tools:~/bin:$HOME/.cargo/bin

umask 022

setopt no_share_history
setopt no_inc_append_history
setopt inc_append_history_time
setopt hist_find_no_dups

function up() {
    # default to 1
    declare -i d=${@:-1};
    # ensure non-negative
    (($d < 0)) && (>&2 echo "up: Error: negative value provided") && return 1;
    # remove last d directories from pwd, append "/" in case result is empty
    cd "$(pwd | sed -E 's;(/[^/]*){0,'$d'}$;;')/";
}
