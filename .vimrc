let mapleader="\<cr>"
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'Lokaltog/vim-easymotion'

Bundle 'majutsushi/tagbar'
Bundle 'terryma/vim-smooth-scroll'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'sukima/xmledit'
Bundle 'tomasr/molokai'



filetype plugin indent on     " required!

set t_Co=256
syntax on
let g:rehash256 = 1

colorscheme molokai
"set background=dark

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set backup		" keep a backup file
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands

set foldmethod=syntax

" Don't use Ex mode, use Q for formatting
noremap Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
inoremap kj <Esc>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
	set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
	autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino
	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!

		" For all text files set 'textwidth' to 78 characters.
		autocmd FileType text setlocal textwidth=78

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

else

	set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif


" My stuff
augroup CursorLine
	au!
	au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
	au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
	au WinLeave * setlocal nocursorline
	au WinLeave * setlocal nocursorcolumn
augroup END
set wildmenu
set wildmode=list:longest
set cursorline
set ttyfast
set laststatus=2
set undofile
set scrolloff=10
set relativenumber
set ignorecase
set incsearch		" do incremental searching
set showmatch
set smartcase
set hidden
set nowrap
set tabstop=4
set shiftwidth=4
set tags=tags;~,~/commontags

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

nnoremap j gj
nnoremap k gk
nnoremap Y y$
nnoremap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>
nnoremap <leader>hs :set hlsearch! hlsearch?<CR>
set gdefault
set clipboard=unnamedplus
nnoremap <leader><space> :noh<cr>
" following 3 maps replaced by smooth scroll
" nnoremap <space> <C-d>
" nnoremap <S-Space> <C-u>
" nnoremap <BS> <C-u>

if has("statusline") && !&cp 
	set laststatus=2 " always show the status bar

	" Start the status line
	set statusline=%f\ %m\ %r 
	set statusline+=Line:%l/%L[%p%%] 
	set statusline+=Col:%v 
	set statusline+=Buf:#%n 
	set statusline+=[%b][0x%B] 
endif


noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 1, 4)<CR>
noremap <silent> <S-space> :call smooth_scroll#up(&scroll, 1, 4)<CR>
noremap <silent> <BS> :call smooth_scroll#up(&scroll, 1, 4)<CR>

noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 1, 4)<CR>
noremap <silent> <space> :call smooth_scroll#down(&scroll, 1, 4)<CR>

noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 1, 8)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 1, 8)<CR>

runtime macros/matchit.vim

set splitbelow
set splitright

map <c-j> <c-w><c-w>
map <c-k> <c-w><s-w>
map <c-l> :vertical resize -7<CR>
map <c-h> :vertical resize +7<CR>
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

nnoremap ftd yiwgg22jotypedef int pa;:w
