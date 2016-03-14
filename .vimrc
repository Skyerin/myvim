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
set incsearch
set showmatch

set hlsearch

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

" Show the command as it's being typed
set showcmd

"augroup myvimrc
"    au!
"    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
"augroup END

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

syntax enable
colorscheme monokai

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
        let excludeDirectory = "--exclude-dir=bower_components --exclude-dir=node_modules --exclude-dir=build --exclude-dir=dist "
    else
        let excludeDirectory = ""
    endif

    :execute "grep! " . excludeDirectory . "--include=*." . a:fileType . " '" . a:searchString . "' -R -i ./"
    :copen
endfunction


" Custom command to run the js & css install
command InstallJsAndCSS execute "!ssh dev 'cd /home/vagrant/frontend && app/console assetic:dump && app/console assets:install'"

command RestartApache execute "!ssh dev 'sudo service apache2 restart'"

command PlannerInstall execute "!cd /home/syed/git/planner2d && npm install && bower install && grunt setup && grunt build"

" PROBLEM: Whenever I wanted to open stuff from the quickfix list, it would go over my current buffer.
" That was an absolute pain. Therefore, the below should fix this! Yay!
:set switchbuf+=usetab,newtab

autocmd FileType php set keywordprg=pman

set pastetoggle=<F2>

" Don't run messdetector on save (default = 1)
let g:phpqa_messdetector_autorun = 0

" Don't run codesniffer on save (default = 1)
let g:phpqa_codesniffer_autorun = 1
let g:phpqa_codesniffer_args = "--standard=/home/syed/git/devenvironment/resources/phpcs.xml"

" Show code coverage on load (default = 0)
let g:phpqa_codecoverage_autorun = 0

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

map <C-o> :set paste<CR>:exe PhpDoc()<CR>:set nopaste<CR>i

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

let g:vdebug_options = {
\ 'path_maps': {"/data/sites/frontend/latest/frontend": "/home/syed/git/frontend", "/data/sites/frontend/latest/frontend/src/Wren" : "/home/syed/git/frontend/src/Wren"},
\ 'server': '0.0.0.0'
\}

" JSHINT stuff
let jshint2_command = '/usr/local/bin/jshint'
let jshint2_read = 1
let jshint2_save = 1

function! DoPrettyJSON()
exe "%!python -m json.tool"
endfunction

command! FormatJSON call DoPrettyJSON()
