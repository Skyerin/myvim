runtime! debian.vim

" pathogen - all my plugin stuff
execute pathogen#infect()

set nocompatible
set undolevels=50000
set smartindent
set tabstop=4
set shiftwidth=4
set hidden
set ignorecase
set wrap

set autowrite

" show search as we search
set incsearch
set showmatch
set hlsearch
" Show the command as it's being typed
set showcmd

" Show trailing spaces, show tabs etc
set list
set listchars=nbsp:.,tab:>.,trail:.,extends:#,

" Use spaces instead of tabs for PSR reasons
set tabstop=4
set shiftwidth=4
set expandtab

" Show line numbers
set number

" Show vertical line. Good for lining up code.
set cursorcolumn

"augroup myvimrc
"    au!
"    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
"augroup END

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

syntax enable
colorscheme elflord

"set background=dark
"let g:solarized_termtrans=1
"let g:solarized_termcolors=256
"let g:solarized_contrast="high"
"let g:solarized_visibility="high"
"colorscheme solarized

" Custom keywords colour scheme
highlight keytopics ctermbg=128 guibg=#AF00D7 ctermfg=015 guifg=#FFFFFF " 128 is a purple colour - background. 015 is white - text.

if has("autocmd")
	if v:version > 701
		" KEYTOPICS
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(TODO:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(THEORY:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(NOTE:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(DISCUSSION:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(IDEA:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(NEEDS ATTENTION:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(EXPLANATION:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(THOUGHT:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(QUESTION:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(UPDATE:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(PROBLEM:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(BIG GIANT HEADACHE:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(DELETE THIS:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(I HAVE NO CLUE:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(EUREKA:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(DISCOVERY:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(ISSUE:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(POSSIBLE FIX:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(SOLUTION:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(WTF:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(FIX THIS:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(FIX THIS BS:\)')
		autocmd Syntax * call matchadd('keytopics', '\W\zs\(NEEDS FIXING:\)')
	endif
endif

if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" TODO: Try and set this up for Javascript. See what happens
set tags=tags;

" find in files function. To use this, the command is :call Search("file extension go here","search string goes here", 1 or 0 (depending if we're in planner or not))
function Search(fileType, searchString, excludeDirectory)
    if a:excludeDirectory
        let excludeDirectory = "--exclude-dir=node_modules --exclude-dir=vendor "
    else
        let excludeDirectory = ""
    endif

    :execute "grep! " . excludeDirectory . "--include=*." . a:fileType . " '" . a:searchString . "' -R -i ./"
    :copen
endfunction

command RestartApache execute "!ssh dev 'sudo service apache2 restart'"

" PROBLEM: Whenever I wanted to open stuff from the quickfix list, it would go over my current buffer.
" That was an absolute pain. Therefore, the below should fix this! Yay!
:set switchbuf+=usetab,newtab

set pastetoggle=<F2>

" Simple re-format for minified Javascript
command! UnMinify call UnMinify()
function! UnMinify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction
