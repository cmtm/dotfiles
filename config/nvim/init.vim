if exists('g:vscode')
    " VSCode extension
    set clipboard=unnamedplus
    set ignorecase
    set smartcase
else
    set runtimepath^=~/.vim,~/.vim/after
    set packpath+=~/.vim
    source ~/.vimrc
endif
