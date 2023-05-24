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
" 変更時にガタつかないようにサイン列を常に表示しておく
set signcolumn=yes

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
" function! AddEndSemicolon()
"   let c = getline('.')[col('$') - 2]
"   if c != ';'
"     return 1
"   else
"     return 0
"   endif
" endfunction
" inoremap <expr>;; AddEndSemicolon() ? '<C-O>$;' : '<C-O>$'

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
" nnoremap <Leader>r :%s///g<Left><Left><Left>

" コマンドラインウィンドウ (:~)
" 入力途中での上下キーでヒストリー出すのを Ctrl+n/p にも割り当て
cnoremap <expr> <C-n> wildmenumode() ? "\<c-n>" : "\<down>"
cnoremap <expr> <C-p> wildmenumode() ? "\<c-p>" : "\<up>"
" ---------------------------------------------------------


" ---------------------------------------------------------
" プラグイン管理
" ---------------------------------------------------------
" 不要なプラグインを停止する
let g:did_install_default_menus = 1
let g:did_install_syntax_menu   = 1
let g:did_indent_on             = 1
let g:did_load_filetypes        = 1
let g:did_load_ftplugin         = 1
let g:loaded_2html_plugin       = 1
let g:loaded_gzip               = 1
let g:loaded_man                = 1
let g:loaded_matchit            = 1
let g:loaded_matchparen         = 1
let g:loaded_netrw              = 1
let g:loaded_netrwPlugin        = 1
let g:loaded_remote_plugins     = 1
let g:loaded_shada_plugin       = 1
let g:loaded_spellfile_plugin   = 1
let g:loaded_tarPlugin          = 1
let g:loaded_tutor_mode_plugin  = 1
let g:loaded_zipPlugin          = 1
let g:skip_loading_mswin        = 1

" OS によって設定ファイルのパスが違う
if has('mac')
  call plug#begin('~/.config/nvim/plugged')
elseif has('linux')
  call plug#begin('~/.config/nvim/plugged')
elseif has('win64') || has('win32')
  call plug#begin('~/AppData/Local/nvim/plugged')
endif

" パフォーマンス改善
Plug 'lewis6991/impatient.nvim'

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
" Plug 'stevearc/dressing.nvim'

" 検索
Plug 'phaazon/hop.nvim'
Plug 'markonm/traces.vim'

" ファイルツリー
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" ターミナル
Plug 'akinsho/toggleterm.nvim'

" バッファ
Plug 'akinsho/bufferline.nvim'

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
Plug 'EdenEast/nightfox.nvim'

" コードハイライト
" e.g. :TSInstall <language_to_install>
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" ファイル・テキスト検索(Fuzzy Finder)
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'
Plug 'dimaportenko/telescope-simulators.nvim'
" 空白文字ハイライト
Plug 'lukas-reineke/indent-blankline.nvim'
" カーソル位置のハイライト
Plug 'RRethy/vim-illuminate'

" Lint Engine
Plug 'dense-analysis/ale'

" Git changes
Plug 'lewis6991/gitsigns.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
"
Plug 'DNLHC/glance.nvim'
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
" Plug 'mfussenegger/nvim-jdtls'
" Android
Plug 'hsanson/vim-android'

" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'nvim-telescope/telescope-dap.nvim'

" GitHub Copilot
Plug 'zbirenbaum/copilot.lua'
Plug 'zbirenbaum/copilot-cmp'


call plug#end()
" ---------------------------------------------------------

" ---------------------------------------------------------
" plewis6991/impatient.nvim
" ---------------------------------------------------------
lua require('impatient')
" ---------------------------------------------------------


" ---------------------------------------------------------
" phaazon/hop.nvim
" ---------------------------------------------------------
lua require'hop'.setup { keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }

" nnoremap f :HopChar2<CR>
nnoremap ff :HopPattern<CR>
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
" kyazdani42/nvim-tree.lua - ファイルツリー
" ---------------------------------------------------------
if !exists('g:vscode')

nnoremap <silent> <C-n> :NvimTreeToggle<CR>
lua << EOF
-- https://github.com/nvim-tree/nvim-tree.lua/blob/master/lua/nvim-tree/keymap-legacy.lua
local M = {}
function M.on_attach(bufnr)
   local api = require("nvim-tree.api")
   local function opts(desc)
     return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
   end
   api.config.mappings.default_on_attach(bufnr)
   vim.keymap.set('n', 'x', api.node.run.system, opts('Open System'))
   vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
   vim.keymap.set('n', '=', api.tree.change_root_to_node, opts('CD'))
   vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Dir Up'))
   vim.keymap.set('n', 'l', api.node.open.edit, opts('Edit'))
   vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Node'))
   vim.keymap.set('n', 's', '', opts(''))
   vim.keymap.set('n', 'sl', '<c-w>l', opts(''))
   vim.keymap.set('n', '<c-t>', "<cmd>ToggleTerm<CR>", opts('ToggleTerm'))
end

require("nvim-tree").setup({
  on_attach = M.on_attach,
  view = {
    adaptive_size = true,
    float = {
      enable = ture,
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,
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
nnoremap <silent> <Leader>s <cmd>Telescope simulators run<CR>

lua << EOF
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      ".git/",
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim",
      "--hidden",
      "--glob",
      "!**/.git/*",
    },
    mappings = {
      i = {
        ["<C-q>"] = "close",
      }
    },
    preview = {
      treesitter = false,
      mime_hook = function(filepath, bufnr, opts)
        local is_image = function(filepath)
          local image_extensions = { "png", "jpg", "jpeg", "gif", "ico", "webp" } -- Supported image formats
          local split_path = vim.split(filepath:lower(), ".", { plain = true })
          local extension = split_path[#split_path]
          return vim.tbl_contains(image_extensions, extension)
        end
        if is_image(filepath) then
          local term = vim.api.nvim_open_term(bufnr, {})
          local function send_output(_, data, _)
            for _, d in ipairs(data) do
              vim.api.nvim_chan_send(term, d .. "\r\n")
            end
          end
          vim.fn.jobstart({
            "viu",
            "-b",
            filepath,
          }, {
            on_stdout = send_output,
            stdout_buffered = true,
          })
        else
          require("telescope.previewers.utils").set_preview_message(
            bufnr,
            opts.winid,
            "Binary cannot be previewed"
          )
        end
      end,
    },
  },
}
require('telescope').load_extension('ui-select')
require('telescope').load_extension('flutter')
require('telescope').load_extension('notify')
require('telescope').load_extension('dap')
require("telescope").load_extension('media_files')
require("simulators").setup({
  android_emulator = true,
  apple_simulator = true,
})
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

colorscheme duskfox
let g:gotham_airline_emphasised_kkinsert = 0

endif
" ---------------------------------------------------------


" ---------------------------------------------------------
" RRethy/vim-hexokinase
" ---------------------------------------------------------
" let g:Hexokinase_highlighters = [ 'virtual' ]
" let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript', 'typescript']
" ---------------------------------------------------------


" ---------------------------------------------------------
" lewis6991/gitsigns.nvim
" ---------------------------------------------------------
if !exists('g:vscode')
lua << EOF
require('gitsigns').setup {
  signs = {
    add          = { hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
    change       = { hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    untracked    = { hl = 'GitSignsAdd'   , text = '┆', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}
EOF
endif


" ---------------------------------------------------------
" RRethy/vim-illuminate
" ---------------------------------------------------------
if !exists('g:vscode')
lua << EOF
require('illuminate').configure({
    providers = {
        'lsp',
        'treesitter',
    },
    delay = 100,
    filetype_overrides = {},
    filetypes_denylist = {
        'dirvish',
        'fugitive',
    },
    filetypes_allowlist = {},
    modes_denylist = {},
    modes_allowlist = {},
    providers_regex_syntax_denylist = {},
    providers_regex_syntax_allowlist = {},
    under_cursor = true,
    large_file_cutoff = nil,
    large_file_overrides = nil,
    min_count_to_highlight = 1,
})

EOF
endif
" ---------------------------------------------------------


" ---------------------------------------------------------
" dense-analysis/ale
" ---------------------------------------------------------
let g:ale_lint_on_enter = 0
let g:ale_sign_column_always = 1
let g:ale_lint_on_save = 0
let g:ale_linters = {
      \ 'markdown': ['textlint'],
      \ 'json': ['jq', 'jsonlint', 'cspell'],
      \ 'yaml': ['yamllint'],
      \ 'go': ['gofmt', 'gopls'],
      \ }
"
let g:ale_fixers = {
      \ '*': ['trim_whitespace'],
      \ 'sh': ['shfmt'],
      \ 'bash': ['shfmt'],
      \ 'zsh': ['shfmt'],
      \ 'markdown': ['prettier'],
      \ 'yaml': ['prettier'],
      \ 'html': ['prettier'],
      \ 'css': ['prettier'],
      \ 'less': ['prettier'],
      \ 'scss': ['prettier'],
      \ 'json': ['prettier'],
      \ 'vue': ['prettier'],
      \ 'svelte': ['prettier'],
      \ 'astro': ['prettier'],
      \ 'javascript': ['prettier', 'eslint'],
      \ 'javascriptreact': ['prettier', 'eslint', 'stylelint'],
      \ 'typescript': ['prettier', 'tslint', 'eslint'],
      \ 'typescriptreact': ['prettier', 'tslint', 'eslint', 'stylelint'],
      \ 'java': ['eclipselsp'],
      \ 'kotlin': ['ktlint'],
      \ 'dart': ['dart-format'],
      \ 'go': ['gofmt', 'goimports'],
      \ 'graphql': ['prettier'],
      \ }
nnoremap <silent> <Leader>f :ALEFix<CR>
" ---------------------------------------------------------


" ---------------------------------------------------------
" zbirenbaum/copilot.lua
" ---------------------------------------------------------
if !exists('g:vscode')
lua << EOF
require('copilot').setup({
  panel = {
    enabled = false,
    auto_refresh = false,
  },
  suggestion = {
    enabled = false,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<M-a>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<M-c>",
    },
  },
  copilot_node_command = 'node', -- Node.js version must be > 16.x
  server_opts_overrides = {},
})
require('copilot_cmp').setup {
  method = 'getCompletionsCycling',
}
EOF
endif
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
end
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
require('mason').setup()
require("mason-lspconfig").setup_handlers({
  function (server_name)
    -- require("lspconfig")[server_name].setup {
    --   on_attach = on_attach,
    --   flags = {
    --     debounce_text_changes = 150,
    --   },
    -- }
    -- require("lspconfig")["dartls"].setup {
    --   on_attach = function(client, bunfs)
    --     local bufopts = { noremap=true, silent=true, buffer=bufnr }
    --     on_attach(client, bunfs)
    --   end,
    --   capabilities = capabilities,
    --   flags = {allow_incremental_sync = true, debounce_text_changes = 500},
    --   cmd = {'dart', 'language-server', '--protocol=lsp'},
    --   init_options = {
    --     onlyAnalyzeProjectsWithOpenFiles = false,
    --     suggestFromUnimportedLibraries = true,
    --     closingLabels = false,
    --     outline = false,
    --     flutterOutline = false,
    --   },
    -- }
    -- require("lspconfig")["svelte"].setup {
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   flags = {
    --     debounce_text_changes = 150,
    --   },
    -- }
    -- require("lspconfig")["astro"].setup {
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   flags = {
    --     debounce_text_changes = 150,
    --   },
    -- }
    require("lspconfig")["tsserver"].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
      },
    }
    -- require("lspconfig")["jdtls"].setup {
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   flags = {
    --     debounce_text_changes = 150,
    --   },
    -- }
    require("lspconfig")["sourcekit"].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
      },
    }
    require("lspconfig")["gopls"].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
      },
    }
    require("lspconfig")["kotlin_language_server"].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
      },
      -- root_dir = function(fname)
        -- return require("lspconfig").root_pattern("build.gradle.kts", "settings.gradle.kts", "build.gradle", "settings.gradle")(fname) or vim.loop.os_homedir()
        -- return require("lspconfig").root_pattern("build.gradle", "settings.gradle")(fname) or vim.loop.os_homedir()
      -- end,
    }
  end,
})

-- false : do not show error/warning/etc.. by virtual text
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { separator = true }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, { separator = true }
)

-- LSP Navigation -- -- -- -- -- -- -- -- -- -- -- -- --
local glance = require('glance')
local actions = glance.actions

glance.setup({
  height = 18, -- Height of the window
  zindex = 45,
  preview_win_opts = { -- Configure preview window options
    cursorline = true,
    number = true,
    wrap = true,
  },
  border = {
    enable = false, -- Show window borders. Only horizontal borders allowed
    top_char = '―',
    bottom_char = '―',
  },
  list = {
    position = 'right', -- Position of the list window 'left'|'right'
    width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
  },
  theme = { -- This feature might not work properly in nvim-0.7.2
    enable = true, -- Will generate colors for the plugin based on your current colorscheme
    mode = 'auto', -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
  },
  mappings = {
    list = {
      ['j'] = actions.next, -- Bring the cursor to the next item in the list
      ['k'] = actions.previous, -- Bring the cursor to the previous item in the list
      ['<Down>'] = actions.next,
      ['<Up>'] = actions.previous,
      ['<Tab>'] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
      ['<S-Tab>'] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
      ['<C-u>'] = actions.preview_scroll_win(5),
      ['<C-d>'] = actions.preview_scroll_win(-5),
      ['v'] = actions.jump_vsplit,
      ['s'] = actions.jump_split,
      ['t'] = actions.jump_tab,
      ['<CR>'] = actions.jump,
      ['o'] = actions.jump,
      ['<leader>l'] = actions.enter_win('preview'), -- Focus preview window
      ['q'] = actions.close,
      ['Q'] = actions.close,
      ['<Esc>'] = actions.close,
      -- ['<Esc>'] = false -- disable a mapping
    },
    preview = {
      ['Q'] = actions.close,
      ['<Tab>'] = actions.next_location,
      ['<S-Tab>'] = actions.previous_location,
      ['<leader>l'] = actions.enter_win('list'), -- Focus list window
    },
  },
  hooks = {},
  folds = {
    fold_closed = '',
    fold_open = '',
    folded = true, -- Automatically fold list on startup
  },
  indent_lines = {
    enable = true,
    icon = '│',
  },
  winbar = {
    enable = true, -- Available strating from nvim-0.8+
  },
})

-- Complete -- -- -- -- -- -- -- -- -- -- -- -- --
local cmp = require('cmp')
local lspkind = require('lspkind')
require('lspkind').init({
  symbol_map = {
    Copilot = "",
  },
})
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
    { name = "copilot", group_index = 2 },
    { name = "nvim_lsp", group_index = 2 },
    { name = "vsnip", group_index = 2 },
    { name = "buffer", group_index = 2 },
    { name = "path", group_index = 2 },
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
  fvm = false,
  ui = {
    border = "rounded",
  },
  widget_guides = { enabled = true },
  outline = {
    open_cmd = "rightbelow 50vnew",
    auto_open = false
  },
  lsp = {
    color = {
      enabled = false,
      foreground = false,
      background = false
    },
    on_attach = function(client, bunfs)
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set('n', '<Leader>m', "<cmd>lua require('telescope').extensions.flutter.commands()<CR>", bufopts)
      vim.keymap.set('n', '<Leader>o', "<cmd>FlutterOutlineToggle<CR>", bufopts)
      on_attach(client, bunfs)
    end,
    -- capabilities = capabilities,
    capabilities = function(config)
      config.specificThingIDontWant = false
      return config
    end,
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      analysisExcludedFolders = {
        vim.fn.expand("$HOME/.pub-cache"),
      },
      renameFilesWithClasses = "prompt",
      updateImportsOnRename = true,
      enableSnippets = true
    }
  },
  closing_tags = {
    enabled = true,
    highlight = "ClosingTags",
    prefix = "-> ",
  },
  dev_log = {
    enabled = true,
    notify_errors = false,
    open_cmd = "tabedit",
  },
  dev_tools = {
    autostart = false,
    auto_open_browser = false,
  },
  debugger = {
    enabled = true,
    -- run_via_dap = true,
    exception_breakpoints = {},
    register_configurations = function(paths)
      -- require("dap").configurations.dart = {}
      require("dap.ext.vscode").load_launchjs()
    end,
  },
}

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
" バッファ
nnoremap [[ :BufferLineCyclePrev<CR>
nnoremap ]] :BufferLineCycleNext<CR>
nnoremap [] :BufferLinePick<CR>
nnoremap ][ :BufferLinePickClose<CR>
nnoremap \][ :BufferLineCloseLeft<CR>
nnoremap \[] :BufferLineCloseRight<CR>
nnoremap \\ :bd<CR>
nnoremap \\\  :bp<CR>

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
t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '80'}}
t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '80'}}
t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '160'}}
t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '160'}}

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
