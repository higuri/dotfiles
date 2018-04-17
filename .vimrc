" .vimrc

" No-Compatible with vi
set nocompatible
" continue loading buffer if buf become no-active
set hidden
" file encoding + crmode.
set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp
set fileformat=dos
set fileformats=dos,mac,unix
" representation characer encoding
set encoding=utf-8
" display double byte character correctly.
set ambiwidth=double
" autochange current directory according to current buffer
" [tips] check current dir -> :pwd 
set autochdir
" location of swap & backup files.
set directory=~/.vimdir
set backupdir=~/.vimdir
if !isdirectory(&directory)
    silent call mkdir(&directory, 'p')
endif

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

" show line number
set number
" show cmd being entered 
set showcmd
" highlight searched word
set hlsearch
" dynamic and incremental search
set incsearch
" hoge == HOGE but Hoge != hoge
set ignorecase
set smartcase
" indentation.
set autoindent
set smartindent
set expandtab
" enable backspace over autoindent and line break
set backspace=indent,eol,start

"
" key-map
"

" Set map special character. After this line, <Leader> means ','
let mapleader=','

nmap <Leader>g <Esc>:vimgrep 
nnoremap <Leader>n :new 
nnoremap <Leader>v :vnew 
nnoremap <Leader>x :bd<CR>
nnoremap <Leader>r :execute '!'.&ft.' %'<CR>
" correct indent pasted character right before
nnoremap <Leader>= =`]
" yank & paste between Vim instances
" TODO: use variable.
vnoremap <silent> <Leader>y :w! ~/.vimdir/.vimyank<CR>
nnoremap <silent> <Leader>y :.w! ~/.vimdir/.vimyank<CR>
nnoremap <silent> <Leader>p :r ~/.vimdir/.vimyank<CR>

" string substitution with yanked. repeat by 'n'.
nnoremap cyw ce<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
nnoremap cyl c$<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
" change Window cmd key
"   <c-w> + hjkl: select window.
"   <c-w> + +-<>: resize window (horizontal/vertical).
inoremap <C-w> <Esc><C-w>
cnoremap <C-w> <C-c><C-w>
" change buffer
nnoremap zj :bn<CR>
nnoremap zk :bp<CR>
nnoremap zz :buffer 
" visual-select search in file
vnoremap * y/<C-r>"<CR>
" visual-select vim-grep ( -> cw[ref: autocmd QuickfixCmdPost] )
vnoremap gg y<Esc>:vimgrep /<C-r>"/j 
vnoremap gf y<Esc>:vimgrep /<C-r>"/j %<CR>
vnoremap gd y<Esc>:vimgrep /<C-r>"/j **/*<CR>

" move command line cursor in emacs way.
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
" command line completion from history.
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>
" Paste at command mode
" [tips] default keymaps
"   <C-u> delete line 
"   <C-h> back space
cnoremap <C-v> <C-r>"

" QuickFix [for vimgrep]
autocmd QuickfixCmdPost vimgrep cw

"
" Plugin management with Vundle.
"
if !isdirectory($HOME.'/.vim/bundle/Vundle.vim')
    silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
endif
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" --- Bundles to be installed ---
" fzf.vim: fuzzy finder in Vim
set rtp+=/usr/local/opt/fzf
Plugin 'junegunn/fzf.vim'
" surround.vim : Delete/change/add parentheses/quotes/XML-tags/much more with ease
Plugin 'tpope/vim-surround'
" The NERD Commenter : A plugin that allows for easy commenting of code for many filetypes. 
Plugin 'scrooloose/nerdcommenter'
" YankRing.vim : Maintains a history of previous yanks, changes and deletes
Plugin 'YankRing.vim'
" snipMate : TextMate-style snippets for Vim 
Plugin 'msanders/snipmate.vim'
" camelcasemotion : Motion through CamelCaseWords and underscore_notation. 
Plugin 'bkad/CamelCaseMotion'
" matchit: extended % matching for XML, HTML.
Plugin 'tmhedberg/matchit'
" tmux-navigator: tmux pane swithing with awareness of Vim splits.
Plugin 'christoomey/vim-tmux-navigator'
" vim-wakatime: quantify vim usage.
Plugin 'wakatime/vim-wakatime'
" vim-make: ':Make' runs closest Makefile.
Plugin 'higuri/vim-make'
" tscwatch.vim: tsc --watch in vim
Plugin 'higuri/tscwatch.vim'
" swift.vim: swift syntax.
Plugin 'keith/swift.vim'
" vim-scala: scala syntax.
Plugin 'derekwyatt/vim-scala'
" vim-colors-solarized: colorscheme 'solarized'
Plugin 'altercation/vim-colors-solarized'
" leafgarland/typescript-vim: typescript syntax.
Plugin 'leafgarland/typescript-vim'
call vundle#end()

syntax on
if isdirectory($HOME.'/.vim/bundle/vim-colors-solarized')
    set background=dark
    let g:solarized_termtrans = 1
    colorscheme solarized
endif
filetype plugin indent on

"
" Plugin setting
"
if isdirectory($HOME.'/.vim/bundle/CamelCaseMotion')
    call camelcasemotion#CreateMotionMappings('<Leader>')
endif
let NERDSpaceDelims = 1
let g:yankring_history_dir = &directory
" fzf.vim
nnoremap <Leader>b :Buffers<CR>
nnoremap ; :Files 

"
" FileType setting
"   These settings have to be evaluated after loading plugins
"   which declare filetypes (e.g. swift.vim, vim-scala).
"

" save the line position when file is closed
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
" disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType * setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType xml,html setlocal tabstop=2 softtabstop=2 shiftwidth=2
" <Leader>r FIXME
autocmd FileType c,cpp nnoremap <Leader>r :execute '!gcc % && ./a.out'<CR>
autocmd FileType javascript nnoremap <Leader>r :execute '!node %'<CR>
autocmd FileType typescript nnoremap <Leader>r :execute '!tsc % && node %:r.js'<CR>
