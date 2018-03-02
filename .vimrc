" VIM run command
let os=substitute(system('uname'), '\n', '', '')

" No-Compatible with vi
set nocompatible
" continue loading buffer if buf become no-active
set hidden
set fileencoding=utf-8
" line feed code
set fileformats=dos,mac,unix
set fileformat=dos
" vim base encoding
set encoding=utf-8
" encodings for auto detect
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp
" display double byte character correctly.
set ambiwidth=double
" autochange current directory according to current buffer
" check current dir -> :pwd 
set autochdir
" location of temporary file(.swp)
set directory=~/tmp/
" share clipboar of system.
" TODO
" set clipboard=unnamed
" save the line position when file is closed
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" statusline
set laststatus=2
" %F: filename
" %m: edit status [+]
" %=\ : right alighn
" %y: file type
" %{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}: [fenc][fileformat]
" %L: num of lines
" %l,%c,%P: current position
set statusline=%F%m%=\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}[LEN=%L]\ %l,%c\ %P

" symbol word highlight
syntax on
" highlight(coloring) theme
" favorites : desert, slate, torte, ron
" You can change each keyword setting by highlight command(:help mysyntax)
" and refer color image by :source $VIMRUNTIME/syntax/colortest.vim
colorscheme slate
highlight Statement ctermfg=darkmagenta
highlight Comment ctermfg=darkcyan

" show number line
set number
" insert auto-indent at newline
set autoindent
set smartindent
" tab setting: tab-indent
set expandtab
set softtabstop=4
set shiftwidth=4
set tabstop=4
" highlight searched word
set hlsearch
" show cmd being entered 
set showcmd
" dynamic and incremental search
set incsearch
" hoge == HOGE but Hoge != hoge
set ignorecase
set smartcase

"
" Plugin manager using vundle.
"   require - git
"   Brief help
"   :BundleList          - list configured bundles
"   :BundleInstall(!)    - install(update) bundles
"   :BundleSearch(!) foo - search(or refresh cache first) for foo
"   :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
Bundle 'gmarik/vundle'
" --- My Bundles here ---
" surround.vim : Delete/change/add parentheses/quotes/XML-tags/much more with ease
Bundle 'tpope/vim-surround'
" The NERD Commenter : A plugin that allows for easy commenting of code for many filetypes. 
Bundle 'scrooloose/nerdcommenter'
" matrix.vim : Matrix screensaver for VIM
Bundle 'uguu-org/vim-matrix-screensaver'
" YankRing.vim : Maintains a history of previous yanks, changes and deletes
Bundle 'YankRing.vim'
" Conque Shell : Run interactive commands inside a Vim buffer 
" Bundle 'Conque-Shell'
Bundle 'carlobaldassi/ConqueTerm'
" pythonhelper : Displays Python class, method or function the cursor is in on the status line 
Bundle 'pythonhelper'
" snipMate : TextMate-style snippets for Vim 
Bundle 'msanders/snipmate.vim'
" camelcasemotion : Motion through CamelCaseWords and underscore_notation. 
Bundle 'bkad/CamelCaseMotion'
" taglist.vim : Source code browser (supports C/C++, java, perl, python, tcl, sql, php, etc)
" Bundle 'taglist.vim'
" swift.vim: swift syntax.
Bundle 'keith/swift.vim'
" vim-scala: scala syntax.
Bundle 'derekwyatt/vim-scala'

filetype plugin indent on
"

"
" Some key-binds...
"
"" emacs(bash command) like command mode
" start of line
cnoremap <C-A>		<Home>
cnoremap <C-B>		<Left>
cnoremap <C-E>		<End>
cnoremap <C-F>		<Right>
cnoremap <C-N>		<Down>
cnoremap <C-P>		<Up>

" other operation is set as default
" <C-u> delete line 
" <C-h> back space
" Paste at command mode
cnoremap <C-v> <C-r>"
" string substitution with yanked. repeat by 'n'.
nnoremap cyw ce<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
nnoremap cyl c$<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
" Short cut to Command mode
inoremap <F1> <Esc>:
nnoremap <F1> <Esc>:
" change Window cmd key
"   <c-w> + hjkl: select window.
"   <c-w> + +-<>: resize window (horizontal/vertical).
inoremap <C-w> <Esc><C-w>
cnoremap <C-w> <C-c><C-w>
" change buffer
nnoremap zj :bn<CR>
nnoremap zk :bp<CR>
nnoremap zz :buffer 
" open/close fold
nnoremap fl zo
nnoremap fh zc
" move cursor @ insert mode
inoremap <C-K>      <Esc>ki
inoremap <C-L>      <Esc>li
inoremap <C-J>      <BS>
" visual-select search in file
vnoremap * y/<C-r>"<CR>
" visual-select vim-grep ( -> cw[ref: autocmd QuickfixCmdPost] )
vnoremap gg y<Esc>:vimgrep /<C-r>"/j 
vnoremap gf y<Esc>:vimgrep /<C-r>"/j %<CR>
vnoremap gd y<Esc>:vimgrep /<C-r>"/j **/*<CR>
" complete word with tab-key
inoremap <expr> <C-e> pumvisible() ? "\<C-e><C-e>" : "\<C-e>"
inoremap <expr> <C-c> pumvisible() ? "\<C-e><C-e><C-u>" : "\<C-c>"
" disable IME @ normalmode.
" TODO
" noremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" Set map special character. After this line, <Leader> means ','
" warning! camelcase.vim uses ',b' ',e' ',w' for move command
let mapleader=','
nmap <Leader>g <Esc>:vimgrep 
nnoremap <Leader>f :FilesystemExplorer<CR>
nnoremap <Leader>l :BufferExplorer<CR>
nnoremap <Leader>x :bd<CR>
nnoremap <Leader>r :execute '!' &ft ' %'<CR>
nnoremap <Leader>t :TlistToggle<CR>
nnoremap <Leader>d ?def\\|class\\|if\\|for\\|while<CR>:noh<CR>

" disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set omnifunc=syntaxcomplete#Complete
set complete+=k
inoremap # X#

" 
autocmd FileType c, cpp nnoremap <Leader>r :execute '!make run'<CR>

" QuickFix [for vimgrep]
autocmd QuickfixCmdPost vimgrep cw

"
" Plugin setting
"
let NERDSpaceDelims = 1
let g:yankring_history_dir = '~/tmp'
command Sh ConqueTerm bash
