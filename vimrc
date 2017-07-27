" ---------------------------------------------------------------------------
"                           .vimrc of lainkun
" ---------------------------------------------------------------------------
" ---------------------------------------------------------------------------
"                                 plugins
" ---------------------------------------------------------------------------
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')
" ---------------------------------------------------------------------------
"                                   git
" ---------------------------------------------------------------------------
Plug 'tpope/vim-fugitive'

" ---------------------------------------------------------------------------
"                                  common
" ---------------------------------------------------------------------------
Plug 'junegunn/seoul256.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-emoji'


" ---------------------------------------------------------------------------
"                                 browsing
" ---------------------------------------------------------------------------
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/vim-slash'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'yggdroot/indentline'
Plug 'majutsushi/tagbar'
Plug 'easymotion/vim-easymotion'


" ---------------------------------------------------------------------------
"                             languages support
" ---------------------------------------------------------------------------


" clojure
Plug 'kovisoft/paredit',    { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-clojure-highlight'
Plug 'junegunn/rainbow_parentheses.vim'


" python
Plug 'hdima/python-syntax'
Plug 'klen/python-mode'
Plug 'nvie/vim-flake8'


" ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'bbatsov/rubocop'


" javascript / node
Plug 'pangloss/vim-javascript'
Plug 'moll/vim-node'
Plug 'marijnh/tern_for_vim', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript'
" js plug settings
let g:javascript_plugin_jsdoc = 1


" typescript
Plug 'leafgarland/typescript-vim'


" html
Plug 'othree/html5.vim'


" css/scss/less
Plug 'cakebaker/scss-syntax.vim'
Plug 'groenewege/vim-less'


" markdown
Plug 'tpope/vim-markdown'

" ---------------------------------------------------------------------------
"                               editor features
" ---------------------------------------------------------------------------
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction
Plug 'scrooloose/syntastic'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'honza/vim-snippets'
Plug 'mattn/emmet-vim'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
call plug#end()


" ---------------------------------------------------------------------------
"                                basic settings
" ---------------------------------------------------------------------------
syntax on
set tags=./tags;/
set number
set showcmd
set wildmenu
set lazyredraw
set showmatch
set backspace=indent,eol,start
set incsearch
set hlsearch
set hidden
set expandtab
set tabstop=2
set shiftwidth=2
set scrolloff=5
set nocursorline
set autoread
set nu
set visualbell
set encoding=utf-8
set list
set nostartofline
set statusline=%<[%n]\ %F\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %=%-14.(%l,%c%V%)\ %P

let g:tagbar_ctags_bin = '/usr/local/bin/ctags'

" ---------------------------------------------------------------------------
"                           Color theme settings
"
" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
" ---------------------------------------------------------------------------
let g:seoul256_background = 236
colo seoul256


" ---------------------------------------------------------------------------
"                                 mappings
" ---------------------------------------------------------------------------


" Basic mappings
let mapleader      = ' '
let maplocalleader = ' '
vnoremap <C-c> "*y
nmap <C-p> :FZF<CR>


" NERDtree toggle
nnoremap <F9> :NERDTreeToggle<cr>


" Tagbar toggle
nmap <F8> :TagbarToggle<CR>


" Easy Align key to format
nmap ga <Plug>(EasyAlign)


" Movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-^> <C-o><C-^>


" EasyMotion keys
nnoremap <leader>f :EasyMotion<cr>


" <tab> / <s-tab> | Circular windows navigation
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W


" Tern navigation
autocmd FileType javascript nnoremap <buffer> <silent> <C-]> :TernDef<CR>
autocmd CompleteDone * pclose


" jk | Escaping!
inoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>


