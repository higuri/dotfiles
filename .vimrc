" .vimrc

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
if !isdirectory($HOME.'/.vim_backup')
  call mkdir($HOME.'/.vim_backup', 'p')
endif
set directory=~/.vim_backup
set backupdir=~/.vim_backup
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
nnoremap <Leader>r :execute '!' &ft ' %'<CR>
nnoremap <Leader>x :bd<CR>
nnoremap <Leader>t :TlistToggle<CR>
nnoremap <Leader>d ?def\\|class\\|if\\|for\\|while<CR>:noh<CR>

"
" FileType setting
"

" disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set omnifunc=syntaxcomplete#Complete
set complete+=k
inoremap # X#

autocmd FileType c,cpp nnoremap <Leader>r :execute '!gcc % && ./a.out'<CR>
autocmd FileType typescript nnoremap <Leader>r :execute '!tsc % && nodejs %:r.js'<CR>

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
" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'
" --- My Bundles here ---
" surround.vim : Delete/change/add parentheses/quotes/XML-tags/much more with ease
Plugin 'tpope/vim-surround'
" The NERD Commenter : A plugin that allows for easy commenting of code for many filetypes. 
Plugin 'scrooloose/nerdcommenter'
" matrix.vim : Matrix screensaver for VIM
Plugin 'uguu-org/vim-matrix-screensaver'
" YankRing.vim : Maintains a history of previous yanks, changes and deletes
Plugin 'YankRing.vim'
" ConquerTerm : Run interactive commands inside a Vim buffer 
Plugin 'carlobaldassi/ConqueTerm'
" snipMate : TextMate-style snippets for Vim 
Plugin 'msanders/snipmate.vim'
" camelcasemotion : Motion through CamelCaseWords and underscore_notation. 
Plugin 'bkad/CamelCaseMotion'
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
let g:yankring_history_dir = '~/.vim_backup'
command Sh ConqueTerm bash
