" 再読み込み
command! ReloadVimrc source $MYVIMRC

" ---------------------------------------------------------
" 基本設定
" ---------------------------------------------------------
" Highlight
syntax on
" <Leader>を`<Space>`に設定
let mapleader = "\<Space>"
map <Space> <Leader>
" <LocalLeader>を`,`に設定
let g:maplocalleader = ','
map , <LocalLeader>

" 保存されていないファイルがあるときは終了前に保存確認
set confirm
" バックアップファイル出力無効
set nobackup
" swpファイル出力無効
set noswapfile
" 外部でファイルに変更がされた場合は読みなおす
set autoread
" 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set hidden
" 入力中のコマンドを表示する
set showcmd
" クリップボード連携
set clipboard&
set clipboard^=unnamedplus
" マウスを有効にする
set mouse=a
" 文字コードの指定
set enc=utf-8
set fenc=utf-8
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
" 行番号
set number
" カーソル行をハイライト
set cursorline
" set cursorcolumn
"　カーソルを行末の一つ先まで移動可能にする
set virtualedit=onemore
" ビープ音を消す
" set visualbell
set vb t_vb=
set novisualbell
" 対応する括弧を強調表示
set showmatch
" 対応する括弧を表示する時間（最小設定）
set matchtime=1 
" ステータス行を常に表示
set laststatus=2
" ファイル名補完
set wildmode=list:longest
" 空白文字の表示
set list
set list listchars=tab:\▸\-
" タブ文字をスペースにする
set expandtab
set tabstop=2
" 自動インデント（前の行から引き継ぎ）
set autoindent
" インデントのネスト上げ下げ
set smartindent
" 自動インデントでずれる幅
set shiftwidth=2
" 検索で大文字小文字を無視
set ignorecase
set smartcase
" インクリメンタルサーチ
set incsearch
" 最後尾まで検索を終えたら次の検索で先頭に移る
set wrapscan
" 検索文字列をハイライトする
set hlsearch
" 置換の時 g オプションをデフォルトで有効にする
set gdefault

if has('win64') || has('win32')
  set shell=pwsh
  set shellcmdflag=-c
  " set shellslash " Windows でもパスの区切り文字を / にする
  " set shellquote=\"
  " set shellxquote=
endif

" ---------------------------------------------------------


" ---------------------------------------------------------
" キーマップ
" ---------------------------------------------------------
" ESC連打でハイライト解除
map <Esc><Esc> :nohlsearch<CR><Esc>

" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

" タブの移動
nmap tf :tabfirst<CR>
nmap tl :tablast<CR>
nmap tt :tabnext<CR>
nmap T :tabprevious<CR>
nmap tc :tabclose<CR>
nmap to :tabonly<CR>
nmap tn :tabnew<CR>

" 画面分割
" https://tamata78.hatenablog.com/entry/2015/10/15/214921
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

" ノーマルモードではセミコロンをコロンに
nnoremap ; :
" 入力モードでは;;で行末にセミコロン
function! AddEndSemicolon()
  let c = getline('.')[col('$') - 2]
  if c != ';'
    return 1
  else
    return 0
  endif
endfunction
inoremap <expr>;; AddEndSemicolon() ? '<C-O>$;' : '<C-O>$'

" 保存・終了時のタイポ修正
cnoremap Q q
cnoremap Q! q!
cnoremap W w
cnoremap W! w!
cnoremap WQ! wq!

" Ctrl+s で保存
nnoremap <C-s> :update<CR>
nnoremap <silent> <s> :update<CR>

" Ctrl+q で :q
nnoremap <C-q> :q<CR>

" w!!でsudoを忘れても保存
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>

" 入力モード中のカーソル移動 
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" 対象の行を移動
nnoremap <C-Up> "zdd<Up>"zP
nnoremap <C-Down> "zdd"zp
" 対象の複数行を移動
vnoremap <C-Up> "zx<Up>"zP`[V`]
vnoremap <C-Down> "zx"zp`[V`]

" Spaceを押した後にrを押すと :%s/// が自動で入力される
nnoremap <Leader>r :%s///g<Left><Left><Left>

" コマンドラインウィンドウ (:~)
" 入力途中での上下キーでヒストリー出すのを Ctrl+n/p にも割り当て
cnoremap <expr> <C-n> wildmenumode() ? "\<c-n>" : "\<down>"
cnoremap <expr> <C-p> wildmenumode() ? "\<c-p>" : "\<up>"
" ---------------------------------------------------------


" ---------------------------------------------------------
" プラグイン管理
" ---------------------------------------------------------
" 不要なプラグインを停止する
let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1


" OS によって設定ファイルのパスが違う
if has('mac')
  call plug#begin('~/.config/nvim/plugged')
elseif has('win64') || has('win32')
  call plug#begin('~/AppData/Local/nvim/plugged')
endif

Plug 'tpope/vim-surround'
Plug 'numToStr/Comment.nvim'
Plug 'machakann/vim-swap'
" incremental search improved
Plug 'haya14busa/is.vim'
Plug 'jiangmiao/auto-pairs'
" スタート画面
Plug 'mhinz/vim-startify'
Plug 'editorconfig/editorconfig-vim'
Plug 'machakann/vim-highlightedyank'
Plug 'nvim-lua/plenary.nvim'

" 検索
Plug 'phaazon/hop.nvim'
Plug 'markonm/traces.vim'

" ファイルツリー
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" ターミナル 
Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'}

" バッファ
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

" ステータスバー
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ウィンドウサイズ
Plug 'simeji/winresizer'

" スクロール
Plug 'karb94/neoscroll.nvim'

" 通知
Plug 'rcarriga/nvim-notify'

" Colorschema
Plug 'whatyouhide/vim-gotham'

" コードハイライト
" e.g. :TSInstall <language_to_install>
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" ファイル・テキスト検索(Fuzzy Finder)
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
" 空白文字ハイライト
Plug 'lukas-reineke/indent-blankline.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
" LSP スニペット
Plug 'hrsh7th/vim-vsnip'
" LSP status 表示
Plug 'j-hui/fidget.nvim'
" LSP アイコンを表示
Plug 'onsails/lspkind-nvim'
" LSP エラーメッセージ
Plug 'folke/trouble.nvim'
" LSP ポップアップ
Plug 'rmagatti/goto-preview'
" Flutter
Plug 'akinsho/flutter-tools.nvim'

" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'nvim-telescope/telescope-dap.nvim'

call plug#end() 
" ---------------------------------------------------------


" ---------------------------------------------------------
" phaazon/hop.nvim
" ---------------------------------------------------------
lua require'hop'.setup { keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }

map f :HopChar2<enter>
map fw :HopWord<enter>
map fl :HopLine<enter>
map fp :HopPattern<enter>
hi HopNextKey guifg=#E06C75
hi HopNextKey1 guifg=#E06C75
hi HopNextKey2 guifg=#E06C75
hi HopUnmatched guifg=#4B5263
" ---------------------------------------------------------


" ---------------------------------------------------------
" machakann/vim-swap
" ---------------------------------------------------------
" ---------------------------------------------------------


" ---------------------------------------------------------
" mhinz/vim-startify - スタート画面カスタム
" ---------------------------------------------------------
if !exists('g:vscode')
let g:startify_files_number = 5
let g:startify_bookmarks = [
          \ { 'i': '~/.config/nvim/init.vim' },
          \ { 'x': '~/.config/' },
          \ { 'z': '~/.zshrc' },
          \ { 'w': '~/.wezterm.lua' },
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
endif
" ---------------------------------------------------------


" ---------------------------------------------------------
" akinsho/bufferline.nvim
" ---------------------------------------------------------
if !exists('g:vscode')

" バッファ 
nnoremap [[ :BufferLineCyclePrev<CR>
nnoremap ]] :BufferLineCycleNext<CR>
nnoremap [] :BufferLinePick<CR>
nnoremap ][ :BufferLinePickClose<CR>
nnoremap \\  :bp<CR>
nnoremap \\\ :bd<CR>

endif
" ---------------------------------------------------------


" ---------------------------------------------------------
" kyazdani42/nvim-tree.lua - ファイルツリー
" ---------------------------------------------------------
if !exists('g:vscode')

nnoremap <silent> <C-n> :NvimTreeToggle<CR>
lua << EOF
require("nvim-tree").setup({
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "/", action = "search_node" },
        { key = "x", action = "system_open" },
        { key = "s", action = "" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})
EOF

endif
" ---------------------------------------------------------


" ---------------------------------------------------------
" nvim-telescope/telescope.nvim - fzf ファイル・コマンド検索
" ---------------------------------------------------------
if !exists('g:vscode')

nnoremap <silent> <C-o> <cmd>lua require('telescope.builtin').find_files({hidden = true})<CR>
nnoremap <silent> <C-g> <cmd>lua require('telescope.builtin').live_grep()<CR>
" nnoremap <Leader>fb <cmd>lua require('telescope.builtin').buffers()<CR>
" nnoremap <Leader>fh <cmd>lua require('telescope.builtin').help_tags()<CR>

lua << EOF
require('telescope').setup{
  defaults = { 
    file_ignore_patterns = { 
      "node_modules",
      ".git/",
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    },
  }
}
require('telescope').load_extension('flutter')
require('telescope').load_extension('ui-select')
require('telescope').load_extension('dap')
EOF

endif
" ---------------------------------------------------------


" ---------------------------------------------------------
" akinsho/toggleterm.nvim ターミナル
" ---------------------------------------------------------
if !exists('g:vscode')

autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
nnoremap <C-t> :ToggleTerm<CR>

lua << EOF
require('toggleterm').setup{
  direction = 'float',
}
EOF

endif
" ---------------------------------------------------------


" ---------------------------------------------------------
" rcarriga/nvim-notify - 通知
" ---------------------------------------------------------
if !exists('g:vscode')
lua << EOF
vim.notify = require("notify")
EOF
endif
" ---------------------------------------------------------


" ---------------------------------------------------------
" whatyouhide/vim-gotham - テーマ
" ---------------------------------------------------------
if !exists('g:vscode')

colorscheme gotham256
let g:gotham_airline_emphasised_kkinsert = 0

endif
" ---------------------------------------------------------


" ---------------------------------------------------------
" LSP
" ---------------------------------------------------------
if !exists('g:vscode')

" LSP Debugging
nnoremap <Leader>k <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <Leader>f <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <Leader>r <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <Leader>dd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>D <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <Leader>ii <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <Leader>tt <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <Leader>n <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <Leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <Leader>e <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap <Leader>] <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <Leader>[ <cmd>lua vim.diagnostic.goto_prev()<CR>
" LSP Popup
nnoremap <Leader>d <cmd>lua require('goto-preview').goto_preview_definition()<CR>
nnoremap <Leader>i <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
nnoremap <Leader>t <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
" エラーメッセージ
nnoremap <Leader>ee <cmd>TroubleToggle<CR>
" nnoremap <Leader>tw <cmd>TroubleToggle workspace_diagnostics<CR>
" nnoremap <Leader>td <cmd>TroubleToggle document_diagnostics<CR>
" nnoremap <Leader>tq <cmd>TroubleToggle quickfix<CR>
" nnoremap <Leader>tl <cmd>TroubleToggle loclist<CR>
" nnoremap <Leader>tR <cmd>TroubleToggle lsp_references<CR>
" Debugging
nnoremap <Leader>b <cmd>lua require('dap').toggle_breakpoint()<CR>
nnoremap <Leader>bc <cmd>lua require('dap').continue()<CR>
nnoremap <Leader>bi <cmd>lua require('dap').step_into()<CR>
nnoremap <Leader>bo <cmd>lua require('dap').step_over()<CR>
nnoremap <Leader>bu <cmd>lua require('dapui').toggle()<CR>
" ブレイクポイントを全て削除
function! s:clearBreakpoints() 
  exec "lua require'dap'.list_breakpoints()"
  for item in getqflist()
    exec "exe " . item.lnum . "|lua require'dap'.toggle_breakpoint()"
  endfor
endfunction
command! ClearBreakpoints call s:clearBreakpoints()
nnoremap <Leader>br <cmd>ClearBreakpoints<CR>

" Flutter
function! s:trigger_hot_reload() abort
  silent exec '!kill -SIGUSR1 "$(pgrep -f flutter_tools.snapshot\ run)" &> /dev/null'
endfunction
function! s:trigger_hot_restart() abort
  silent exec '!kill -SIGUSR2 "$(pgrep -f flutter_tools.snapshot\ run)" &> /dev/null'
endfunction
function! s:flutter()
  command! FlutterHotReload call s:trigger_hot_reload()
  command! FlutterHotRestart call s:trigger_hot_restart()
  nnoremap <Leader>m <cmd>lua require('telescope').extensions.flutter.commands()<CR>
endfunction
augroup dart
  autocmd!
  autocmd BufRead,BufNewFile *.dart call s:flutter()
augroup end

lua << EOF
-- Mason -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('mason').setup()
require("mason-lspconfig").setup_handlers({
  function (server_name) 
    require("lspconfig")[server_name].setup {
        flags = {
            debounce_text_changes = 150,
        },
    }
  end,
})

-- false : do not show error/warning/etc.. by virtual text
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  -- vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
-- )
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { separator = true }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, { separator = true }
)

-- Complete -- -- -- -- -- -- -- -- -- -- -- -- -- 
local cmp = require('cmp')
local lspkind = require('lspkind')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      maxwidth = 50,
      before = function (entry, vim_item)
        return vim_item
      end
    })
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
    -- { name = "buffer" },
    -- { name = "path" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})

-- Flutter -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
require('flutter-tools').setup{
  flutter_lookup_cmd = 'asdf where flutter',
  ui = { border = "rounded" },
  decorations = {
    statusline = {
      app_version = false,
      device = true,
    }
  },
  widget_guides = { enabled = true },
  outline = {
    auto_open = false
  },
  lsp = {
    capabilities = capabilities,
    color = {
      enabled = false,
    },
    settings = {
      analysisExcludedFolders = {
        vim.fn.expand("$HOME/.pub-cache"),
      }
    }
  },
  closing_tags = {
    enabled = true,
    highlight = "ClosingTags",
    prefix = "-> ",
  },
  dev_log = {
    enabled = false,
    open_cmd = "tabedit",
  },
  debugger = {
    enabled = true,
    run_via_dap = true,
    register_configurations = function(paths)
      -- require("dap").adapters.dart = {
      --   type = "executable",
      --   command = "flutter",
      --   args = {"debug_adapter"}
      -- }
      -- require("dap").configurations.dart = {
      --   dartSdkPath = paths.dart_sdk,
      --   flutterSdkPath = paths.flutter_sdk,
      -- }
      require("dap.ext.vscode").load_launchjs()
    end,
  },
}

-- Highlight -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
require("nvim-treesitter.configs").setup {
  highlight = {
    enable = false,
  }
}

-- エラーメッセージ -- -- -- -- -- -- -- -- -- -- -- -
require("trouble").setup {
  position = "bottom",
  height = 5,
  -- auto_open = true,
  auto_close = true,
}

-- Status -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
require('fidget').setup{
  text = {
    spinner = 'moon',
  },
}

-- Debugging -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  expand_lines = vim.fn.has("nvim-0.7"),
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      }, 
      size = 45, -- columns
      position = "right",
    },
  },
})

-- Popup -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
require('goto-preview').setup {
  height = 40;
  width = 160;
}
EOF

endif
" ---------------------------------------------------------

" ---------------------------------------------------------
" akinsho/bufferline.nvim
" ---------------------------------------------------------
if !exists('g:vscode')
set termguicolors
lua require("bufferline").setup{}
endif
" ---------------------------------------------------------


" ---------------------------------------------------------
" karb94/neoscroll.nvim - スムーススクロール
" ---------------------------------------------------------
if !exists('g:vscode')
lua << EOF
require('neoscroll').setup()
local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '100'}}
t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '100'}}
t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '200'}}
t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '200'}}

require('neoscroll.config').set_mappings(t)
EOF
endif
" ---------------------------------------------------------


" ---------------------------------------------------------
" numToStr/Comment.nvim - コメントアウト
" ---------------------------------------------------------
if !exists('g:vscode')
lua require('Comment').setup()
endif
" ---------------------------------------------------------
