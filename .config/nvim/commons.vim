set enc=utf-8
set fenc=utf-8
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp

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

syntax on

set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set clipboard=unnamed
set mouse=a

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
" ESC連打でハイライト解除
map <Esc><Esc> :nohlsearch<CR><Esc>

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

" w!!でsudoを忘れても保存
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>

" // Plugins
" 不要なプラグインを停止する
let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

call plug#begin('~/.config/nvim/plugged')

Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tommcdo/vim-exchange'
Plug 'haya14busa/is.vim'
" 検索
Plug 'markonm/traces.vim'

" ファイルツリー
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
" ステータスバー
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" スクロール
Plug 'yuttie/comfortable-motion.vim'

" キーマップチートシート
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

if executable('fzf')
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
endif

" Editor
" instaled coc-json, coc-kotlin
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc-json', {'do': 'yarn --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn --frozen-lockfile'}
Plug 'udalov/kotlin-vim'

" Colorschema
Plug 'whatyouhide/vim-gotham'

call plug#end()

" easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase  = 0
nmap f <Plug>(easymotion-overwin-f2)
nmap fw <Plug>(easymotion-overwin-w)

" Ctrl + / でコメントアウト
nnoremap <c-_> :Commentary<CR>
vnoremap <c-_> :Commentary<CR>

" Exchange 
" nmap cx <Plug>(Exchange)
" xmap X <Plug>(Exchange)
" nmap cxc <Plug>(ExchangeClear)
" nmap cxx <Plug>(ExchangeLine)

" VSCode では無効
if !exists('g:vscode')

  " // fern.vim
  " ドットファイル表示
  let g:fern#default_hidden=1

  " アイコンを表示（iTerm2 のフォントを変更する必要がある）
  let g:fern#renderer = "nerdfont"

  " ツリーを開く
  nnoremap <silent> <C-j> :Fern . -width=40 -drawer -reveal=% -toggle<cr>

  " アイコンにカラーをつける
  augroup my-glyph-palette
    autocmd! *
    autocmd FileType fern call glyph_palette#apply()
    autocmd FileType nerdtree,startify call glyph_palette#apply()
  augroup END
  function! s:init_fern() abort

    " ツリーは行番号非表示
    set nonumber

    " ツリーを閉じる
    nnoremap <silent><buffer><nowait> q :<C-u>quit<CR>
    nnoremap <silent><buffer><nowait> <C-j> :<C-u>quit<CR>
  endfunction

  augroup fern-custom
    autocmd! *
    autocmd FileType fern call s:init_fern()
  augroup END

  " // fzf
  if executable('fzf')

    nnoremap <silent> <c-o> :Files<CR>
    nnoremap <silent> <Leader>h :History<CR>
    nnoremap <silent> <Leader>H :Helptags<CR>

    if executable('rg')
      set grepprg=rg\ --vimgrep\ --smart-case\ --follow
      " make the Rg command only search for text and not the file name
      command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
      nnoremap <silent> <c-g> :Rg<CR>
    endif

  endif

  " キーマップチートシート
  nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
  nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

  " ステータスバー
  let g:airline_theme='monochrome'

  " スクロールバー
  let g:comfortable_motion_interval = 1000 / 120
  
  " // coc
  nnoremap <silent> ,c :<C-u>CocList<CR>

endif

colorscheme gotham256

