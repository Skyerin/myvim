runtime! debian.vim

" pathogen - all my plugin stuff
execute pathogen#infect()

set nocompatible
set history=50000
set undolevels=50000
set smartindent
set tabstop=4
set shiftwidth=4
set hidden
set ignorecase
set wrap

set autowrite
set incsearch
set showmatch

" Show trailing spaces, show tabs etc
set list
set listchars=nbsp:.,tab:>.,trail:.,extends:#,

" Show line numbers
set number

" Show the command as it's being typed
set showcmd

" Tags file; using a project wide one. Because I'm lazy!!!
set tags=./tags,./../tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
