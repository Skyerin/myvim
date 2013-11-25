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

set cursorline
set cursorcolumn

set endofline

" Show the command as it's being typed
set showcmd

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

let autocmd_colorscheme_loaded = 1

" Custom keywords colour scheme
highlight keytopics ctermbg=LightCyan guibg=LightCyan ctermfg=Yellow guifg=Yellow

if has("autocmd")
	if v:version > 701
		autocmd Syntax * call matchadd('keytopics',  '\W\zs\(THEORY:\)')
		autocmd Syntax * call matchadd('keytopics',  '\W\zs\(NOTE:\)')
		autocmd Syntax * call matchadd('keytopics',  '\W\zs\(DISCUSSION:\)')
		autocmd Syntax * call matchadd('keytopics',  '\W\zs\(IDEA:\)')
		autocmd Syntax * call matchadd('keytopics',  '\W\zs\(NEEDS ATTENTION:\)')
		autocmd Syntax * call matchadd('keytopics',  '\W\zs\(EXPLANATION:\)')
	endif
endif

if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Tags file; using a project wide one. Because I'm lazy!!!
set tags=./tags,./../tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags

" I want a find in files. Why? Because I said so. Sometimes the tags don't work!
map <F4> :execute "vimgrep /" . expand("<cword>") . "/j ../**/*" <Bar> cw<CR>
" Problem: Whenever I wanted to open stuff from the quickfix list, it would go over my current buffer. That was an absolute pain. Therefore, the below should fix this! Yay!
:set switchbuf+=usetab,newtab

" Can we get this to work? Please...?
autocmd FileType php set keywordprg=pman

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark
