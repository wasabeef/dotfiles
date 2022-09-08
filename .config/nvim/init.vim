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

set termguicolors

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
" ノーマルモードでは 0 で行頭、9 で行末
nnoremap 0 ^
nnoremap 9 $

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
elseif has('linux')
  call plug#begin('~/.config/nvim/plugged')
elseif has('win64') || has('win32')
  call plug#begin('~/AppData/Local/nvim/plugged')
endif

Plug 'tpope/vim-surround'
Plug 'numToStr/Comment.nvim'
Plug 'machakann/vim-swap'
" incremental search improved
Plug 'haya14busa/is.vim'
Plug 'windwp/nvim-autopairs'
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
" カラーコード
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Lint Engine
Plug 'dense-analysis/ale'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
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
" 定義・シンボル
Plug 'liuchengxu/vista.vim'
" Flutter
Plug 'akinsho/flutter-tools.nvim'
" TypeScript
Plug 'jose-elias-alvarez/typescript.nvim'
" Java
Plug 'mfussenegger/nvim-jdtls'
" Android
Plug 'hsanson/vim-android'

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

nnoremap f :HopChar2<CR>
nnoremap fw :HopWord<CR>
nnoremap fl :HopLine<CR>
hi HopNextKey guifg=#E06C75
hi HopNextKey1 guifg=#E06C75
hi HopNextKey2 guifg=#E06C75
hi HopUnmatched guifg=#4B5263
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
nnoremap \][ :%bd<CR>
nnoremap \\ :bd<CR>
nnoremap \\\  :bp<CR>

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
        { key = "?", action = "toggle_help" },
        { key = "t", action = "tabnew" },
        { key = "=", action = "cd" },
        { key = "-", action = "dir_up" },
        { key = "l", action = "edit" },
        { key = "h", action = "close_node" },
        { key = "<C-t>", action = "" },
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
nnoremap <silent> <C-p> <cmd>lua require('telescope.builtin').oldfiles()<CR>
nnoremap <silent> <C-g> <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <silent> <C-c> <cmd>lua require('telescope.builtin').commands()<CR>
nnoremap <silent> <C-z> <cmd>lua require('telescope.builtin').keymaps()<CR>
nnoremap <silent> <Leader>h <cmd>Telescope notify<CR>

lua << EOF
require('telescope').setup{
  defaults = { 
    file_ignore_patterns = { 
      "node_modules",
      ".git/",
    },
    mappings = {
      i = {
        ["<C-q>"] = "close",
      }
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
require('telescope').load_extension('ui-select')
require('telescope').load_extension('flutter')
require('telescope').load_extension('notify')
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
require('toggleterm').setup({
  direction = 'float',
})
EOF

endif
" ---------------------------------------------------------


" ---------------------------------------------------------
" rcarriga/nvim-notify - 通知
" ---------------------------------------------------------
if !exists('g:vscode')
lua << EOF
vim.notify = require("notify")
require("notify").setup({
  stages = "slide",
  render = "default",
  background_colour = "Normal",
  level = 2, -- trace = 0, debug, info, warn, error
  timeout = 3000,
  fps = 60,
  on_open = nil,
  on_close = nil,
})
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
" RRethy/vim-hexokinase
" ---------------------------------------------------------
let g:Hexokinase_highlighters = [ 'virtual' ]
let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript', 'typescript']
" ---------------------------------------------------------


" ---------------------------------------------------------
" dense-analysis/ale - 
" ---------------------------------------------------------
let g:ale_lint_on_enter = 0
let g:ale_sign_column_always = 1
let g:ale_lint_on_save = 0
let g:ale_linters = {
      \ 'markdown': ['textlint'],
      \ 'json': ['jq', 'jsonlint', 'cspell'],
      \ }
" Supported tools: https://github.com/dense-analysis/ale/blob/master/supported-tools.md
let g:ale_fixers = {
      \ '*': ['trim_whitespace'],
      \ 'markdown': ['prettier'],
      \ 'html': ['prettier'],
      \ 'css': ['prettier'],
      \ 'less': ['prettier'],
      \ 'scss': ['prettier'],
      \ 'json': ['prettier'],
      \ 'graphql': ['prettier'],
      \ 'vue': ['prettier'],
      \ 'yaml': ['prettier'],
      \ 'javascript': ['prettier', 'eslint'],
      \ 'javascriptreact': ['prettier', 'eslint', 'stylelint'],
      \ 'typescript': ['prettier', 'tslint', 'eslint'],
      \ 'typescriptreact': ['prettier', 'tslint', 'eslint', 'stylelint'],
      \ 'dart': ['dart-format'],
      \ 'kotlin': ['ktlint'],
      \ 'java': ['eclipselsp'],
      \ }
nnoremap <silent> <Leader>f :ALEFix<CR>
" ---------------------------------------------------------


" ---------------------------------------------------------
" LSP
" ---------------------------------------------------------
if !exists('g:vscode')
lua << EOF
-- Mason -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  -- LSP Debugging
  vim.keymap.set('n', '<Leader>k', vim.lsp.buf.hover, bufopts)
  -- vim.keymap.set('n', '<Leader>f', vim.lsp.buf.formatting, bufopts) -- use ale
  vim.keymap.set('n', '<Leader>r', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<Leader>dd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<Leader>D', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<Leader>ii', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<Leader>tt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<Leader>n', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', '<Leader>]', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', '<Leader>[', vim.diagnostic.goto_prev, bufopts)
  -- LSP Popup
  vim.keymap.set('n', '<Leader>d', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", bufopts)
  vim.keymap.set('n', '<Leader>i', "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", bufopts)
  vim.keymap.set('n', '<Leader>t', "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", bufopts)
  -- エラーメッセージ
  vim.keymap.set('n', '<Leader>ee', "<cmd>TroubleToggle<CR>", bufopts)
  vim.keymap.set('n', '<Leader>tw', "<cmd>TroubleToggle workspace_diagnostics<CR>", bufopts)
  vim.keymap.set('n', '<Leader>td', "<cmd>TroubleToggle document_diagnostics<CR>", bufopts)
  vim.keymap.set('n', '<Leader>tq', "<cmd>TroubleToggle quickfix<CR>", bufopts)
  vim.keymap.set('n', '<Leader>tl', "<cmd>TroubleToggle loclist<CR>", bufopts)
  vim.keymap.set('n', '<Leader>tR', "<cmd>TroubleToggle lsp_references<CR>", bufopts)
  -- Debugging
  vim.keymap.set('n', '<Leader>b', "<cmd>lua require('dap').toggle_breakpoint()<CR>", bufopts)
  vim.keymap.set('n', '<Leader>bc', "<cmd>lua require('dap').continue()<CR>", bufopts)
  vim.keymap.set('n', '<Leader>bi', "<cmd>lua require('dap').step_into()<CR>", bufopts)
  vim.keymap.set('n', '<Leader>bo', "<cmd>lua require('dap').step_over()<CR>", bufopts)
  vim.keymap.set('n', '<Leader>br', "<cmd>lua require('dap').clear_breakpoints()<CR>", bufopts)
  vim.keymap.set('n', '<Leader>bu', "<cmd>lua require('dapui').toggle()<CR>", bufopts)
  vim.keymap.set('n', '<Leader>be', "<cmd>lua require('dap').defaults.dart.exception_breakpoints = {}<CR>", bufopts)
end
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('mason').setup()
require("mason-lspconfig").setup_handlers({
  function (server_name) 
    -- require("lspconfig")[server_name].setup {
    --   on_attach = on_attach,
    --   flags = {
    --     debounce_text_changes = 150,
    --   },
    -- }
    require("lspconfig")["jdtls"].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    }
    require("lspconfig")["kotlin_language_server"].setup {
      on_attach = on_attach,
      capabilities = capabilities,
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
    { name = "buffer" },
    { name = "path" },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
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
    open_cmd = "rightbelow 50vnew",
    auto_open = false
  },
  lsp = {
    on_attach = function(client, bunfs)
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set('n', '<Leader>m', "<cmd>lua require('telescope').extensions.flutter.commands()<CR>", bufopts)
      vim.keymap.set('n', '<Leader>o', "<cmd>FlutterOutlineToggle<CR>", bufopts)
      on_attach(client, bunfs)
    end,
    capabilities = capabilities,
    color = {
      enabled = true,
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
      require("dap.ext.vscode").load_launchjs()
    end,
  },
}

-- TypeScript -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
require("typescript").setup({
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false,
  server = {
    on_attach = on_attach,
   },
})


-- Highlight -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
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
  timer = {
    spinner_rate = 125,
    fidget_decay = 10000,
    task_decay = 3000,
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
      size = 10, -- columns
      position = "bottom",
    },
  },
})

-- Popup -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
require('goto-preview').setup {
  height = 40;
  width = 160;
}
EOF

"" Vista """""""""""""""""""""""""""""""""""""""""
let g:vista_default_executive = 'nvim_lsp'
let g:vista#renderer#enable_icon = 1
let g:vista_sidebar_position = 'rightbelow 50vnew'
nnoremap <Leader>v <cmd>Vista!!<CR>

endif
" ---------------------------------------------------------


" ---------------------------------------------------------
" hsanson/vim-android
" ---------------------------------------------------------
if !exists('g:vscode')
let g:gradle_path = $GRADLE_HOME
let g:android_sdk_path = $ANDROID_HOME
endif
" ---------------------------------------------------------

" ---------------------------------------------------------
" akinsho/bufferline.nvim
" ---------------------------------------------------------
if !exists('g:vscode')
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


" ---------------------------------------------------------
" windwp/nvim-autopairs
" ---------------------------------------------------------
if !exists('g:vscode')
lua << EOF
require("nvim-autopairs").setup {}
EOF
endif
" ---------------------------------------------------------

