runtime! archlinux.vim
let mapleader="\<cr>"
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/Vundle.vim'

" My Bundles here:
"
" original repos on github
" Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'majutsushi/tagbar'
Plugin 'terryma/vim-smooth-scroll'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'mbbill/undotree'
Plugin 'sukima/xmledit'
Plugin 'xolox/vim-lua-ftplugin'
Plugin 'xolox/vim-misc'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()

filetype plugin indent on     " required!

set t_Co=256
syntax on
let g:rehash256 = 1

set background=dark
colorscheme solarized
"set background=dark
"
let g:tagbar_sort = 0

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set backup        " keep a backup file
set history=1000
set ruler        " show the cursor position all the time
set showcmd        " display incomplete commands

set confirm

set foldmethod=syntax
set foldcolumn=2
set nofoldenable

" Don't use Ex mode, use Q for formatting
noremap Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Remove delay when leaving insert move
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

if has("autocmd")
    augroup vimrcEx
        au!
        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        " Also don't do it when the mark is in the first line, that is the default
        " position when opening a file.
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif
    augroup END
    augroup CursorLine
        au!
        au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
        au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
        au WinLeave * setlocal nocursorline
        au WinLeave * setlocal nocursorcolumn
    augroup END

else
    set autoindent        " always set autoindenting on
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif


" My stuff
set wildmenu
set wildignorecase
set wildmode=longest,list:longest
set cursorline
set virtualedit=block
set ttyfast
set laststatus=2
set scrolloff=7
set sidescrolloff=5
set relativenumber
set ignorecase
set incsearch        " do incremental searching
set showmatch
set smartcase
set hidden
" set nowrap
set gdefault
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
set shiftround
set clipboard=unnamedplus,autoselect

set tags=./tags;/,tags,~/lc/tags

set nrformats-=octal

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

nnoremap <F8> :TagbarToggle<CR> 
nnoremap <F5> :UndotreeToggle<cr>

nnoremap j gj
nnoremap k gk
nnoremap Y y$
nnoremap <silent> <leader>tw :set wrap!<CR>:set wrap?<CR>
nnoremap <silent> <leader>N  :set relativenumber!<CR>
nnoremap <leader>hs :set hlsearch! hlsearch?<CR>
nnoremap <leader><space> :noh<cr>
nnoremap <leader>l :/\%>80v.\+<cr>
" following 3 maps replaced by smooth scroll
" nnoremap <space> <C-d>
" nnoremap <S-Space> <C-u>
" nnoremap <BS> <C-u>

nnoremap <silent> <c-u> :call smooth_scroll#up(&scroll, 1, 4)<CR>
nnoremap <silent> <S-space> :call smooth_scroll#up(&scroll, 1, 4)<CR>
nnoremap <silent> <BS> :call smooth_scroll#up(&scroll, 1, 4)<CR>

nnoremap <silent> <c-d> :call smooth_scroll#down(&scroll, 1, 4)<CR>
nnoremap <silent> <space> :call smooth_scroll#down(&scroll, 1, 4)<CR>

nnoremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 1, 8)<CR>
nnoremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 1, 8)<CR>

runtime macros/matchit.vim

set splitbelow
set splitright

noremap <c-j> <c-w><c-w>
noremap <c-k> <c-w><s-w>
noremap <c-l> :vertical resize -7<CR>
noremap <c-h> :vertical resize +7<CR>
nnoremap <s-h> <C-w><
nnoremap <s-l> <C-w>>



" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory($HOME . '/.vim/backup') == 0
    :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backupdir^=./.vim-backup/
set backup

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif
