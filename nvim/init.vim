" VIM PLUG START
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'tomasr/molokai'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'lsdr/monokai'
Plug 'kien/ctrlp.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
call plug#end()
" VIM PLUG END

" color settings
set t_Co=256
let g:solarized_termcolors=256
set termguicolors

syntax enable
syntax on

" ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|virtualenv_run\|__pycache__\|docker-venv'
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_powerline_fonts = 1

set tabstop=2
set shiftwidth=2
set expandtab

" KEY MAPS
nmap gn :tabnew<CR>
nmap gl :tabnext<CR>
nmap gh :tabNext<CR>
nmap gq :tabclose<CR>

set showmatch
set ignorecase
set smartcase
set backspace=indent,eol,start
set smarttab
set hlsearch
set incsearch
set number
" NO BEEPS
set noerrorbells

" Window Navigation uses Ctrl key
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" noremap <leader>h :exec "NERDTree " expand("%:h")<CR>
noremap <leader>h :NERDTreeFind<CR>
nnoremap <leader>n :NERDTree .<CR>
nmap <silent> ,/ :nohlsearch<CR>
nmap ; :

colorscheme palenight
" colorscheme solarized8_high
" set background=

source $HOME/.config/nvim/coc_setup.vim
