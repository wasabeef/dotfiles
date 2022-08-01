" 再読み込み
command! ReloadVimrc source $MYVIMRC
" 共通設定
source ~/.config/nvim/commons.vim

" // Plugins
" 不要なプラグインを停止する
let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-surround'
Plug 'numToStr/Comment.nvim'
Plug 'tommcdo/vim-exchange'
Plug 'haya14busa/is.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mhinz/vim-startify'
Plug 'editorconfig/editorconfig-vim'
Plug 'machakann/vim-highlightedyank'

" 検索
Plug 'phaazon/hop.nvim'
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

" ウィンドウサイズ
Plug 'simeji/winresizer'

" スクロール
Plug 'karb94/neoscroll.nvim'

" Colorschema
Plug 'whatyouhide/vim-gotham'

" キーマップチートシート
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" Editor
" 多様なファイル形式に対応
" Plug 'sheerun/vim-polyglot'

" e.g. :TSInstall <language_to_install>
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'nvim-telescope/telescope-dap.nvim'

call plug#end()

" hop.vim
lua require'hop'.setup { keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }
map f :HopChar2<enter>
map fw :HopWord<enter>
map fl :HopLine<enter>
map fp :HopPattern<enter>
hi HopNextKey guifg=#E06C75
hi HopNextKey1 guifg=#E06C75
hi HopNextKey2 guifg=#E06C75
hi HopUnmatched guifg=#4B5263

" gcc でコメントアウト
lua require('Comment').setup()

" Exchange 
" nmap cx <Plug>(Exchange)
" xmap X <Plug>(Exchange)
" nmap cxc <Plug>(ExchangeClear)
" nmap cxx <Plug>(ExchangeLine)

" VSCode では無効
if !exists('g:vscode')

  " スタート画面
  let g:startify_files_number = 10
  let g:startify_bookmarks = [
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'x': '~/.config/nvim/' },
            \ { 'z': '~/.zshrc' },
            \ ]
  function! s:gitModified()
      let files = systemlist('git ls-files -m 2>/dev/null')
      return map(files, "{'line': v:val, 'path': v:val}")
  endfunction
  function! s:gitUntracked()
      let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
      return map(files, "{'line': v:val, 'path': v:val}")
  endfunction
  let g:startify_lists = [
            \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
            \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
            \ { 'type': 'files',     'header': ['   Last Opened Files'] },
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
            \ { 'type': 'sessions',  'header': ['   Sessions'] },
                    \ ]

  " // fern.vim
  " ドットファイル表示
  let g:fern#default_hidden=1

  " アイコンを表示（iTerm2 のフォントを変更する必要がある）
  let g:fern#renderer = "nerdfont"

  " ツリーを開く
  nnoremap <silent> <C-q> :Fern . -width=40 -drawer -reveal=% -toggle<CR>

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
  endfunction

  augroup fern-custom
    autocmd! *
    autocmd FileType fern call s:init_fern()
  augroup END

  " Telescope
  " nnoremap <silent> <C-o> :Telescope find_files<CR>
  " nnoremap <silent> <C-g> :Telescope live_grep<CR>
  " nnoremap <Leader>fb :Telescope buffers<CR>
  " nnoremap <Leader>fh :Telescope help_tags<CR>
  nnoremap <silent> <C-o> <cmd>lua require('telescope.builtin').find_files()<cr>
  nnoremap <silent> <C-g> <cmd>lua require('telescope.builtin').live_grep()<cr>
  nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
  nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

  " キーマップチートシート
  nnoremap <silent> <Leader>      :<C-u>WhichKey '<Space>'<CR>
  nnoremap <silent> <localleader> :<C-u>WhichKey  ','<CR>

  " ステータスバー
  let g:gotham_airline_emphasised_insert = 0

  " スクロール
  lua require('neoscroll').setup()
  
lua << EOF
require("dapui").setup()
require('telescope').load_extension('dap')
require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
  }
}
EOF

endif

colorscheme gotham256

