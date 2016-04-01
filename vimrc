"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   ________         _
"  |  ____  \   _   | |
"  | |____) |  (_)  | |   _
"  |  ______/   _   | |__/ /   _____
"  | |         | |  |  _  /   /  _  \
"  | |         | |  | | \ \  |  (_)  \
"  |_|         |_|  |_|  \_\  \____/\_\
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: LeoMao
"
" Version: 3.8.0
"
" Sections:
"    -> Map leader settings
"    -> Plugin Settings
"    -> General
"    -> VIM UI
"    -> Colors and Fonts
"    -> Files, backups and undo
"    -> Text, tab and indent related
"    -> Fold Settings
"    -> Visual mode related
"    -> Command mode related
"    -> Moving around, tabs and buffers
"    -> Statusline
"    -> Tags
"    -> Key mappings
"    -> Cope
"    -> Language section
"    -> grep
"    -> MISC
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" => General {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500
" shell
set shell=$SHELL
" not compatible with the old-fashion vi mode
if !has('nvim')
  set nocompatible
  " set term inside tmux for xterm-key on (nvim doesn't need this)
  if &term =~ '^screen' && exists('$TMUX')
    if &term =~ '256color'
      set term=xterm-256color
    else
      set term=xterm
    endif
  endif
endif

" Enable filetype plugin (called by vim-plug)
"filetype plugin indent on

" Set to auto read when a file is changed from the outside
set autoread

" Clear auto cmd for reload vimrc
autocmd!
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Map leader settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set map leader to ' '
let mapleader = ' '
let maplocalleader = ' '
let g:mapleader = ' '
let g:maplocalleader = ' '
runtime .vimrc.leader
" }}}
" => Plugin settings {{{
""""""""""""""""""""""""""""""
" include matchit plugins in vim
if !exists('g:loaded_matchit')
  runtime macros/matchit.vim
endif

" --- vim-plug plugin --- {{{
execute plug#begin()

" NOTE:
" - leomao/lightline-pika is my personal settings.

Plug 'cakebaker/scss-syntax.vim', { 'for': [ 'scss', 'sass' ] }
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'itchyny/lightline.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'leomao/lightline-pika'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'mattn/emmet-vim', { 'for': ['html', 'css'] }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'scrooloose/nerdcommenter'
Plug 'szw/vim-tags'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'vim-scripts/OmniCppComplete', { 'for': 'cpp' }
Plug 'wavded/vim-stylus', { 'for': 'stylus' }

"include custom plugin
runtime .vimrc.plugin

execute plug#end()
" }}}

" --- netrw plugin (built-in) --- {{{
let g:netrw_liststyle = 3
let g:netrw_altv = 1
" }}}

" --- fzf plugin --- {{{
nnoremap <leader>ff <ESC>:FZF<CR>
nnoremap <leader>bf <ESC>:Buffers<CR>
" }}}

" --- Buffer plugin --- {{{
let g:bufExplorerSortBy = 'name'
let g:bufExplorerShowRelativePath = 1
let g:bufExplorerShowNoName = 1
" }}}

" --- Tagbar plugin --- {{{
nnoremap <silent> <leader>tb :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_width = 25
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 0
" }}}

" --- vim tags plugin --- {{{
let g:vim_tags_use_language_field = 1
let g:vim_tags_project_tags_command = '{CTAGS}
      \ -R --c++-kinds=+pl --fields=+iaS --extra=+q
      \ {OPTIONS} {DIRECTORY} 2>/dev/null'

noremap <F12> <ESC>:TagsGenerate!<CR>
" }}}

" --- vimtex --- {{{
let g:vimtex_fold_enabled = 0
let g:vimtex_imaps_leader = ';'
let g:vimtex_quickfix_ignored_warnings = [
      \ 'Underfull',
      \ 'Overfull',
      \ 'specifier changed to',
      \ 'xparse/redefine-command',
      \ 'script-not-exist',
      \ ]
" }}}

" --- NERD Commenter plugin --- {{{
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 0
let g:NERDRemoveExtraSpaces = 1
map <leader>cc <plug>NERDCommenterComment
map <leader>cu <plug>NERDCommenterUncomment
map <leader>c<space> <plug>NERDCommenterToggle
" }}}

" --- undotree plugin --- {{{
noremap <silent><F5> <ESC>:UndotreeToggle<CR>
" }}}

" --- Omni complete functions --- {{{
set completeopt=menuone
set omnifunc=syntaxcomplete#Complete

let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=python3complete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" }}}

" --- Emmet --- {{{
" let g:user_zen_leader_key = '<c-m>'
let g:user_emmet_install_global = 0
au Filetype html,css EmmetInstall
" }}}
"
" --- lightline pika --- {{{
let g:lightline_pika_patchfont = {
      \ 'leftsep': "\ue0b0",
      \ 'leftsubsep': "\ue0b1",
      \ 'rightsep': "\ue0b2",
      \ 'rightsubsep': "\ue0b3",
      \ 'branch': "\ue0a0",
      \ 'linecolumn': "\ue0a1",
      \ 'readonly': "\ue0a2",
      \ }
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => VIM UI {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the curors - when moving vertical
set so=7
set wildignorecase
set wildmenu "Turn on WiLd menu
set guitablabel=%t
" stuff to ignore when tab completing
set wildignore=*.o,*.obj,*~,*.synctex.gz,*.pdf

" let alt key can be mapped
set winaltkeys=no
set ruler "Always show current position

if has('gui_running')
  set guioptions-=T "remove toolbar
  set guioptions-=m "remove menubar
  set guioptions-=r "remove scrollbar
endif

" line number will be highlighted if set rnu
"set cursorline "highlight current line *Slow*
set cmdheight=1 "The commandbar height
"set showcmd "display what command was typed
set noshowmode "display current mode

set nu "line number
set rnu "line number (relative number)
set hid "Change buffer - without saving
" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,[,]

set ignorecase "Ignore case when searching
set smartcase

set hlsearch "Highlight search things
set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros
set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=0 "How many tenths of a second to blink
" time out of mappings
set timeout
set ttimeoutlen=10
" No sound on errors
set novisualbell
set noerrorbells
set tm=500

set mouse=a
if !has('nvim')
  set t_vb=
  set ttymouse=xterm2
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Colors, Fonts, Encoding {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on " Enable syntax highlight
colorscheme pika
" Set font according to system
if has('gui_running')
  if has('win32') || has('win64')
    set gfn=Consolas:h16
  else
    set gfn=Monospace\ 16
  endif
endif
set fileencodings=utf8
set encoding=utf8
" format options
set fo+=Mm " for multi btye character
set fo+=crql
set fo-=t
set ffs=unix,dos,mac " Default file types
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Files, backups and undo {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

" Persistent undo
if has('persistent_undo')
  set undodir=$HOME/.vim/.undodir
  set undofile
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Text, tab and indent related {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set smarttab

set cino+=g0.5s,h0.5s,(0,W2s

" line break on 80 characters
set tw=80
" color column after 'textwidth'
set colorcolumn=+1

set ai "Auto indent
set wrap " Wrap lines
" set nowrap " don't Wrap lines
" set si " Set Smart indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Fold Settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable
set foldlevelstart=10
set fdm=syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Visual mode related {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Really useful!
" In visual mode when you press * or # to search for the current selection
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
vnoremap <silent> * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Command mode related {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set current path when vim start
autocmd VimEnter * cd %:p:h
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Moving around, windows, tabs and buffers {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
nnoremap j gj
nnoremap k gk

inoremap <C-l> <Del>

nnoremap <C-down>  <C-w>j
nnoremap <C-left>  <C-w>h
nnoremap <C-right> <C-w>l
nnoremap <C-up>    <C-w>k

nnoremap <leader>bd :bd<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bn :bn<CR>

" don't jump to the begin of the line
set nosol

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Statusline {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the statusline
set laststatus=2

" Format the statusline
"set statusline=\ %f%m%r%h\ %w\ %=%y\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\"}\ %4l/%4L:%3c
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Tags {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au Filetype cpp setl tags+=~/.vim/tags/cpptags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Key mappings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set pastetoggle=<F2>

" Remap VIM 0
noremap 0 ^

" increase and decrease number under the cursor
nnoremap + <C-a>
nnoremap - <C-x>

set clipboard+=unnamed

" Move lines of text using CTRL+[jk]
nnoremap <C-j> :m+<CR>:echo "move line down"<CR>
nnoremap <C-k> :m-2<CR>:echo "move line up"<CR>
vnoremap <C-j> :m'>+<CR>:echo "move block down"<CR>gv
vnoremap <C-k> :m'<-2<CR>:echo "move block up"<CR>gv

nnoremap <silent><leader>/ :nohl<CR>

" left hand esc
nnoremap <C-e> <ESC>
inoremap <C-e> <ESC>
vnoremap <C-e> <ESC>

" smarter command line
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" Fast saving
nnoremap <leader>w :w!<CR>
" save with sudo
command! -nargs=0 Wsudo :w !sudo tee > /dev/null %

noremap <silent><F9> <ESC>:wa!<CR>:make<CR><CR>:cw<CR>

" check the syntax group under the cursor
noremap <F7> :echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<'
\ . synIDattr(synID(line('.'),col('.'),0),'name') . '> lo<'
\ . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Cope {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do :help cope if you are unsure what cope is. It's super useful!
noremap <silent><F8> <ESC>:call QFSwitch()<CR>
function! QFSwitch()
  redir => ls_output
  execute ':silent! ls'
  redir END

  let exists = match(ls_output, '[Quickfix List')
  if exists == -1
    execute ':copen'
  else
    execute ':cclose'
  endif
endfunction

noremap <silent><leader>cn :cn<CR>
noremap <silent><leader>cp :cp<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Language section {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- python --- {{{
let python_highlight_all = 1
" }}}
" --- latex --- {{{
let g:tex_flavor = 'latex'
let g:tex_fast = 'Mm'
" }}}
" --- bison/yacc --- {{{
let g:yacc_uses_cpp = 1
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Load custom settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime .vimrc.custom
" }}}
" vim:fdm=marker:foldlevel=0