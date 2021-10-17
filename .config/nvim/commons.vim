syntax on

" <Leader>を`<Space>`に設定
let mapleader = "\<Space>"
map <Space> <Leader>
" <LocalLeader>を`,`に設定
let g:maplocalleader = ','
map , <LocalLeader>

" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

" ESC連打でハイライト解除
map <Esc><Esc> :nohlsearch<CR><Esc>

" w!!でsudoを忘れても保存
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>

set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set clipboard=unnamed
set mouse=a
set enc=utf-8
set fenc=utf-8
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp

" // 見た目系
set number
set cursorline
set cursorcolumn
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest

" // タブ系
set list listchars=tab:\▸\-
set expandtab
set tabstop=2
set shiftwidth=2
" 移動
nmap tf :tabfirst<cr>
nmap tl :tablast<cr>
nmap tt :tabnext<cr>
nmap T :tabprevious<cr>
nmap tc :tabclose<cr>
nmap to :tabonly<cr>
nmap tn :tabnew<cr>

" // 画面分割
" s を無効
nmap s <Nop>
nmap sj <C-w>j
nmap sk <C-w>k
nmap sl <C-w>l
nmap sh <C-w>h
nmap sJ <C-w>J
nmap sK <C-w>K
nmap sL <C-w>L
nmap sH <C-w>H
nmap sn gt
nmap sp gT
nmap s= <C-w>=
nmap sw <C-w>w
nmap so <C-w>_<C-w><Bar>
nmap sO <C-w>=
nmap sN :<C-u>bn<CR>
nmap sP :<C-u>bp<CR>
nmap st :<C-u>tabnew<CR>
nmap ss :<C-u>sp<CR>
nmap sv :<C-u>vs<CR>
nmap sq :<C-u>q<CR>
nmap sQ :<C-u>bd<CR>

" // 検索系
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

" // 編集系
" 入力モード中のカーソル移動 
:imap <c-h> <Left>
:imap <c-j> <Down>
:imap <c-k> <Up>
:imap <c-l> <Right>
" 対象の行を移動
nnoremap <C-Up> "zdd<Up>"zP
nnoremap <C-Down> "zdd"zp
" 対象の複数行を移動
vnoremap <C-Up> "zx<Up>"zP`[V`]
vnoremap <C-Down> "zx"zp`[V`]
" Spaceを押した後にrを押すと :%s/// が自動で入力される
nnoremap <Leader>r :%s///g<Left><Left><Left>

