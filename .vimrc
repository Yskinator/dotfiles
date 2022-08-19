
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2016 Mar 25
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Search  down into subfolders
set path+=**

" Display all matching files when we tab complete
set wildmenu

" Tabs and indents consist of 4 spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Fold by indents
set foldmethod=indent nofoldenable foldnestmax=1

" Set line numbers and relative line numbers
set nu rnu

" Make searching case insensitive unless the search includes an upper case
" character
set ignorecase
set smartcase

" Set , as the leader key
let mapleader = ","

" Create a tags file
command! MakeTags !ctags -R --exclude=.git --exclude=env --exclude=env38 .

" File browsing configuration
let g:netrw_banner=0            " disable banner
let g:netrw_browse_split=4      " open in prior window
let g:netrw_altv=1              " open splits to the right
let g:netrw_liststyle=3         " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  "set backup		" keep a backup file (restore to previous version)
  "set undofile		" keep an undo file (undo changes after closing)
endif
set history=1000	" keep 1000 lines of command line history
"set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Disable arrow keys to get into better habits
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>

" Use <F3> to toggle indentation when pasting text
set pastetoggle=<F3>

" Synch clipboard and default register for copy-pasting between terminals
set clipboard^=unnamed

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=
  function! TMouse()
    if &mouse==""
      set mouse=nv
    else
      set mouse=
    endif
  endfunction
  command! TM :call TMouse()
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  "Make the 81st column stand out
  highlight ColorColumn ctermbg=DarkGrey
  call matchadd('ColorColumn', '\%81v', 100)
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " Automatically update the tags file when writing a .py or a .cs file
  autocmd BufWritePost *.py *.cs :MakeTags

  " Shortcut to vimrc, and automatically source vimrc when updated.
  map <leader>vimrc :tabe ~/.vimrc<cr>
  autocmd BufWritePost ~/.vimrc source ~/.vimrc

  " Triger `autoread` when files changes on disk
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
  autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
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

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit
