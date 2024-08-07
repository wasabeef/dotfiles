---@diagnostic disable: undefined-global, missing-fields
-- ---------------------------------------------------------
-- 基本設定
-- ---------------------------------------------------------
-- Highlight
vim.cmd 'syntax on'
-- <Leader>を`<Space>`に設定
vim.g.mapleader = ' '
vim.keymap.set('n', ' ', '<Leader>', {})
-- <LocalLeader>を`,`に設定
vim.g.maplocalleader = ','
vim.keymap.set('n', ',', '<LocalLeader>', {})

-- 保存されていないファイルがあるときは終了前に保存確認
vim.opt.confirm = true
-- バックアップファイル出力無効
vim.opt.backup = false
-- swpファイル出力無効
vim.opt.swapfile = false
-- 外部でファイルに変更がされた場合は読みなおす
vim.opt.autoread = true
-- 保存されていないファイルがあるときでも別のファイルを開くことが出来る
vim.opt.hidden = true
-- 入力中のコマンドを表示する
vim.opt.showcmd = true
-- クリップボード連携
vim.opt.clipboard = 'unnamedplus'
-- マウスを有効にする
vim.opt.mouse = 'a'
vim.opt.mousemoveevent = true
-- 文字コードの指定
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.fileencodings = 'utf-8,iso-2022-jp,cp932,euc-jp'
-- ビープ音を消す
vim.opt.visualbell = true
vim.opt.errorbells = false
-- ステータスを常に表示、複数バッファでも一つ
vim.opt.laststatus = 3
-- ファイル名補完
vim.opt.wildmode = 'list:longest'
-- コマンドの補完
vim.opt.wildmenu = true
-- True Color
vim.opt.termguicolors = true
-- コマンドラインの高さを非表示
vim.opt.cmdheight = 0
-- ウィンドウを半透明にする
vim.opt.winblend = 10
vim.opt.pumblend = 10
-- スクロール時に再描画しない
vim.opt.lazyredraw = true

-- ---------------------------------------------------------
-- 表示設定
-- ---------------------------------------------------------
-- 行番号
vim.opt.number = true
-- カーソル行をハイライト
vim.opt.cursorline = true
-- カーソルを行末の一つ先まで移動可能にする
-- vim.opt.virtualedit = 'onemore'
-- 対応する括弧を強調表示
vim.opt.showmatch = true
-- 対応する括弧を表示する時間（最小設定）
vim.opt.matchtime = 1
-- 空白文字の表示
-- vim.opt.list = true
-- vim.opt.listchars = 'tab:→ ,eol:↵,trail:·,extends:↷,precedes:↶'

-- ---------------------------------------------------------
-- インデントとタブ設定
-- ---------------------------------------------------------
-- タブ文字をスペースにする
vim.opt.expandtab = true
-- タブの幅
vim.opt.tabstop = 2
-- 自動インデント（前の行から引き継ぎ）
vim.opt.autoindent = true
-- インデントのネスト上げ下げ
vim.opt.smartindent = true
-- 自動インデントでずれる幅
vim.opt.shiftwidth = 2

-- ---------------------------------------------------------
-- 検索設定
-- ---------------------------------------------------------
-- 検索で大文字小文字を無視
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- インクリメンタルサーチ
vim.opt.incsearch = true
-- 最後尾まで検索を終えたら次の検索で先頭に移る
vim.opt.wrapscan = true
-- 検索文字列をハイライトする
vim.opt.hlsearch = true
-- 置換の時 g オプションをデフォルトで有効にする
vim.opt.gdefault = true

-- ---------------------------------------------------------
-- セッション設定
-- ---------------------------------------------------------
-- セッションの保存・復元
-- blank: 空のウィンドウも含める
-- buffers: 開いているバッファーも含める
-- curdir: 現在のディレクトリを含める
-- folds: フォールドの状態を含める
-- help: ヘルプウィンドウを含める
-- tabpages: タブページも含める
-- winsize: ウィンドウのサイズを含める
-- winpos: ウィンドウの位置を含める
-- terminal: ターミナルウィンドウも含める
-- localoptions: ローカルオプション（バッファーやウィンドウの設定）を含める
vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- ---------------------------------------------------------
-- その他の設定
-- ---------------------------------------------------------
-- 変更時にガタつかないようにサイン列を常に表示しておく
vim.opt.signcolumn = 'yes'
-- スペルチェック
-- vim.opt.spell = true
-- vim.opt.spelllang = "en,cjk"
-- vim.opt_local.spelloptions:append("noplainbuffer")

-- ---------------------------------------------------------
-- キーマップ
-- ---------------------------------------------------------
local keymap_opts = { noremap = true, silent = false }

-- ESC連打でハイライト解除
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR><Esc>', keymap_opts)

-- 折り返し時に表示行単位での移動できるようにする
vim.keymap.set('n', 'j', 'gj', keymap_opts)
vim.keymap.set('v', 'j', 'gj', keymap_opts)
vim.keymap.set('n', 'k', 'gk', keymap_opts)
vim.keymap.set('v', 'k', 'gk', keymap_opts)

-- 画面分割
vim.keymap.set('n', 's', '<Nop>', keymap_opts)
-- 移動
vim.keymap.set('n', 'sj', '<C-w>j', keymap_opts)
vim.keymap.set('n', 'sk', '<C-w>k', keymap_opts)
vim.keymap.set('n', 'sl', '<C-w>l', keymap_opts)
vim.keymap.set('n', 'sh', '<C-w>h', keymap_opts)
-- 最下段に移動し、幅を最大にする
vim.keymap.set('n', 'sJ', '<C-w>J', keymap_opts)
-- 最上段に移動し、幅を最大にする
vim.keymap.set('n', 'sK', '<C-w>K', keymap_opts)
-- 最右列に移動し、幅を最大にする
vim.keymap.set('n', 'sL', '<C-w>L', keymap_opts)
-- 最左列に移動し、幅を最大にする
vim.keymap.set('n', 'sH', '<C-w>H', keymap_opts)
-- 新しいタブページへ移動する
vim.keymap.set('n', 'sT', '<C-w>T', keymap_opts)
vim.keymap.set('n', 'sn', 'gt', keymap_opts)
vim.keymap.set('n', 'sp', 'gT', keymap_opts)
vim.keymap.set('n', 's=', '<C-w>=', keymap_opts)
vim.keymap.set('n', 'sw', '<C-w>w', keymap_opts)
-- バッファの最小化
vim.keymap.set('n', 'so', '<C-w>_<C-w>|', keymap_opts)
-- バッファの最小化を戻す
vim.keymap.set('n', 'sO', '<C-w>=', keymap_opts)
-- 前のバッファ
vim.keymap.set('n', 'sN', ':<C-u>bn<CR>', keymap_opts)
-- 次のバッファ
vim.keymap.set('n', 'sP', ':<C-u>bp<CR>', keymap_opts)
-- 新規タブ
vim.keymap.set('n', 'st', ':<C-u>tabnew<CR>', keymap_opts)
-- 横分割
vim.keymap.set('n', 'ss', ':<C-u>sp<CR>', keymap_opts)
-- 縦分割
vim.keymap.set('n', 'sv', ':<C-u>vs<CR>', keymap_opts)
-- 閉じる
vim.keymap.set('n', 'sq', ':<C-u>q<CR>', keymap_opts)
vim.keymap.set('n', 'sQ', ':<C-u>bd<CR>', keymap_opts)

-- ノーマルモードではセミコロンをコロンに
vim.keymap.set('n', ';', ':', keymap_opts)
-- ノーマルモードでは 0 で行頭、9 で行末
vim.keymap.set('n', '0', '^', keymap_opts)
vim.keymap.set('n', '9', '$', keymap_opts)

-- 保存・終了時のタイポ修正
vim.keymap.set('c', 'Q', 'q', keymap_opts)
vim.keymap.set('c', 'Q!', 'q!', keymap_opts)
vim.keymap.set('c', 'W', 'w', keymap_opts)
vim.keymap.set('c', 'W!', 'w!', keymap_opts)
vim.keymap.set('c', 'WQ!', 'wq!', keymap_opts)

-- Ctrl+s で保存
vim.keymap.set('n', '<C-s>', ':update<CR>', keymap_opts)
vim.keymap.set('n', '<s>', ':update<CR>', keymap_opts)

-- Ctrl+q で :q
vim.keymap.set('n', '<C-q>', ':q<CR>', keymap_opts)

-- w!!でsudoを忘れても保存
vim.keymap.set('c', 'w!!', 'w !sudo tee > /dev/null %<CR> :e!<CR>', keymap_opts)

-- <C-a> で全選択
vim.keymap.set({ 'n', 'v' }, '<C-a>', '<ESC>ggVG<CR>', keymap_opts)

-- 入力モード中のカーソル移動
vim.keymap.set('i', '<C-h>', '<Left>', keymap_opts)
vim.keymap.set('i', '<C-j>', '<Down>', keymap_opts)
vim.keymap.set('i', '<C-k>', '<Up>', keymap_opts)
vim.keymap.set('i', '<C-l>', '<Right>', keymap_opts)

-- 対象の行を移動 -- use mini.move
-- vim.keymap.set("n", "<M-k>", '"zdd<Up>"zP', keymap_opts)
-- vim.keymap.set("n", "<M-j>", '"zdd"zp', keymap_opts)
-- 対象の複数行を移動 -- use mini.move
-- vim.keymap.set("v", "<M-k>", '"zx<Up>"zP`[V`]', keymap_opts)
-- vim.keymap.set("v", "<M-j>", '"zx"zp`[V`]', keymap_opts)

-- Ctrl + p で繰り返しヤンクした文字をペースト
-- vim.keymap.set("v", "<C-p>", '"0p', { silent = true })
-- Ctrl + m を無効
-- vim.keymap.set("n", "<C-m>", "<Nop>", keymap_opts)

-- コマンドラインウィンドウ (:~)
-- 入力途中での上下キーでヒストリー出すのを Ctrl+n/p にも割り当て
vim.keymap.set('c', '<C-n>', 'wildmenumode() ? "\\<c-n>" : "\\<down>"', { expr = true })
vim.keymap.set('c', '<C-p>', 'wildmenumode() ? "\\<c-p>" : "\\<up>"', { expr = true })

-- LSP
vim.keymap.set('n', '<Leader>K', vim.lsp.buf.hover, keymap_opts)
-- vim.keymap.set('n', '<Leader>f', vim.lsp.buf.formatting, keymap_opts) -- use conform
vim.keymap.set('n', '<Leader>R', vim.lsp.buf.references, keymap_opts)
vim.keymap.set('n', '<Leader>D', vim.lsp.buf.definition, keymap_opts)
-- vim.keymap.set("n", "<Leader>D", vim.lsp.buf.declaration, keymap_opts)
vim.keymap.set('n', '<Leader>I', vim.lsp.buf.implementation, keymap_opts)
vim.keymap.set('n', '<Leader>T', vim.lsp.buf.type_definition, keymap_opts)
vim.keymap.set('n', '<Leader>n', vim.lsp.buf.rename, keymap_opts)
vim.keymap.set('n', '<Leader>A', vim.lsp.buf.code_action, keymap_opts)
vim.keymap.set('n', '<Leader>E', vim.diagnostic.open_float, keymap_opts)
vim.keymap.set('n', '<Leader>]', vim.diagnostic.goto_next, keymap_opts)
vim.keymap.set('n', '<Leader>[', vim.diagnostic.goto_prev, keymap_opts)

-- ---------------------------------------------------------
-- Lazy.nvim セットアップ
-- ---------------------------------------------------------
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- パフォーマンス
vim.loader.enable()
-- 不要なプラグインを停止する
vim.g.did_indent_on = 1
vim.g.did_install_default_menus = 1
vim.g.did_install_syntax_menu = 1
vim.g.did_load_filetypes = 1
vim.g.did_load_ftplugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_rplugin = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spec = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.skip_loading_mswin = 1

-- 前回開いたファイルのカーソル位置を復旧する
vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('restore_cursor', { clear = true }),
  pattern = '*',
  callback = function()
    local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, { row, col })
    end
  end,
})

require('lazy').setup {
  checker = {
    enabled = false,
    concurrency = 8,
  },
  spec = {
    -- Event Order
    -- https://vi.stackexchange.com/questions/4493/what-is-the-order-of-winenter-bufenter-bufread-syntax-filetype-events

    -- テーマ
    {
      'uloco/bluloco.nvim',
      event = 'VimEnter',
      dependencies = { 'rktjmp/lush.nvim' },
      config = function()
        require('bluloco').setup {
          style = 'dark',
          transparent = false,
          italics = false,
          terminal = vim.fn.has 'gui_running' == 1,
          guicursor = false,
        }

        vim.cmd 'colorscheme bluloco'
      end,
    },

    -- アイコン
    {
      'echasnovski/mini.icons',
      event = 'VimEnter',
      opts = {
        file = {
          ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
          ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
        },
        filetype = {
          dotenv = { glyph = '', hl = 'MiniIconsYellow' },
        },
      },
      init = function()
        package.preload['nvim-web-devicons'] = function()
          require('mini.icons').mock_nvim_web_devicons()
          return package.loaded['nvim-web-devicons']
        end
      end,
    },

    -- スタート画面
    {
      'goolord/alpha-nvim',
      event = 'VimEnter',
      config = function()
        local alpha = require 'alpha'
        local dashboard = require 'alpha.themes.dashboard'
        dashboard.section.header.val = {
          -- Using img2art
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⢀⣶⣿⣿⣿⣿⣿⣿⣻⡷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣾⣿⣿⣿⣿⣿⣿⣿⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⢀⣼⡻⣟⣫⣭⣿⢿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣤⣴⣦⣴⣶⣦⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⣴⣟⠋⣈⠿⠋⢑⡊⠚⢃⡉⣿⢽⡻⣿⣿⠿⣷⣄⠀⠀⠀⢀⣠⣴⣶⣿⡿⠿⣿⣿⣿⣿⣿⢶⣦⣤⣄⣠⣤⣶⣿⣿⢿⡟⢿⡿⠿⡻⢯⢯⠹⣿⣦⣄⡀⠀⠀⠀⠀⠀⢀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⡿⠟⣻⢿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⢠⣿⠄⠤⡉⠐⠋⠉⠁⠈⠈⠉⠁⠄⠹⢤⠠⠪⣧⢿⠿⣿⣿⣿⢿⣿⣿⡿⢾⡾⢲⢍⣉⣙⣿⢿⣿⣻⣿⣿⡯⣝⣻⠛⠛⠂⠈⠁⠀⠀⠀⠰⣶⡈⠻⣿⣿⣶⣀⣀⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⡀⠀⠀⠹⣧⢿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⣿⡿⡀⠀⠁⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠎⢓⣶⣿⣿⣿⣿⣧⣼⣻⣶⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡉⡡⡦⠀⠀⠀⠀⠀⠀⠀⢻⡿⠀⣿⣗⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⡷⠿⢿⣿⣿⣿⣿⣿⣿⣶⣤⣄⣋⣼⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠇⡂⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣼⢆⠀⠀⠀⠀⠀⠀⠀⠀⢐⠟⠗⢺⣿⣿⣿⣿⣿⣿⣿⣫⡄⢀⢈⠷⣴⠇⣿⣿⢛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠇⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠠⢛⠀⡐⣓⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⠟⠛⣿⣿⣏⠏⣹⡿⢿⣿⣿⣿⣿⣿⢧⡀⠀⠀⠀⣀⢤⣿⡛⡙⠮⣙⣹⣿⣿⣿⣿⣿⣿⣝⢟⣩⣬⡗⣶⠻⣿⣿⣕⢷⣿⣿⣿⣿⣿⣿⠟⠛⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠘⣈⢡⣿⠟⠙⡲⠄⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⡿⣻⣿⡿⣿⣿⣿⣿⣿⣿⠁⠀⠈⠉⠀⠀⠀⠉⠉⠀⠈⠁⠀⠙⢿⣿⣿⣿⣶⣐⡤⣶⣾⣟⣧⡥⠂⠋⠘⣫⣿⣿⣿⣿⡿⠿⡿⣻⣿⡯⠩⠠⠾⠝⣸⣿⣿⣷⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠈⠄⠀⠀⠹⠿⠃⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣯⣽⣷⢿⣿⣿⠟⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣦⣄⠀⠻⣿⣿⣿⣿⣷⠾⠷⠌⢍⠛⡁⠀⣐⣿⣿⣿⣿⣿⣘⣷⢷⣿⣿⣷⣦⣤⣵⡼⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠴⠿⣧⣓⢾⣀⣠⣽⣿⣿⢯⢯⣯⣧⡉⢸⠍⠁⠀⠀⣀⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⣷⡄⠀⠩⣿⣿⣇⠒⠷⠄⠀⢁⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⡞⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠁⠠⠞⠛⠋⢓⣿⣿⡋⣠⣬⣾⢿⣉⡁⠁⠀⠀⠀⣴⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⢹⣿⣿⣿⠟⡶⢤⡀⢀⣿⣿⣦⠶⠾⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣜⣿⢿⣿⣿⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⡿⢻⠻⣻⢿⡿⠁⠈⠁⠀⠀⠐⠙⢿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠹⣿⠛⠀⢀⠀⠀⠀⠙⣿⣿⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣟⠋⠛⠛⠛⢿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⡿⠃⡼⢰⡿⠂⠀⠀⠀⠀⠀⠀⠶⠤⠤⠙⠻⠻⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠠⠀⠐⠹⣿⡇⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡅⠈⠀⠉⠁⢈⣷⣦⣠⡆⡀⠀⢻⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⢓⣘⢠⡼⠰⠃⠀⠀⠀⠀⠖⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⢿⣧⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣿⣿⣿⣿⣿⣇⣀⠀⣀⣼⣿⣿⣿⣿⣿⠀⠨⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⢻⡯⠤⠼⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠀⠀⠀⠀⠀⠀⠀⢮⣿⠀⢀⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣟⣿⣿⣿⡿⡿⠿⠛⠓⠈⠟⠛⢿⢿⣿⣿⣿⣿⣿⣶⣼⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠾⡵⠀⣰⡖⠈⠀⠀⠀⠀⠷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣇⢀⠀⠀⠀⠀⠀⠸⢿⡄⣸⣿⣿⣿⣿⣿⣿⣿⡿⠟⢠⣶⣿⣿⣿⣿⠁⢿⣿⣿⡿⠀⠀⣀⣤⣼⣿⣿⣿⣿⣿⠓⠚⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡇⠰⠀⠘⣍⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣶⣾⣿⣦⡤⡷⢄⣽⣿⣿⣿⣷⣤⣀⡀⠀⠀⣯⣿⣿⣿⣿⣿⣿⣿⣿⠟⠉⠀⢰⣾⣿⣿⣿⣿⣿⣶⣾⣿⣟⣥⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢐⠀⣄⡀⠀⢔⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⢠⣿⣿⣿⣿⣿⣿⣨⡎⠹⣿⣿⣿⣿⣿⣿⣷⡄⠀⡺⢽⣿⣿⣿⣿⣿⡿⠛⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⣠⡄⠀⠹⠀⠀⠂⠀⠀⠀⣠⠈⠄⠀⠀⠀⢀⡀⠀⠀⣀⣶⣂⣿⣿⣿⣿⣿⣿⣿⡡⠀⠀⣙⣿⣿⣿⣿⣿⣿⡏⠰⡇⠘⠟⠻⣿⣿⣿⡇⠀⠀⠀⠈⠩⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡯⠭⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⢀⣴⣿⣷⠌⠐⠀⠀⠂⠀⢀⡼⠂⠀⠀⠀⠀⠀⢿⣿⣾⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠛⠹⣿⣿⣿⣿⠃⠀⠹⡆⠀⠀⠈⠻⢿⠃⠀⠀⠀⠀⠀⠒⠾⣿⣿⣿⣿⣿⣿⡿⠟⠉⠻⠿⣛⠿⠧⠤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⡀⢂⠚⠀⠀⠀⣜⠀⠀⠀⢀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠂⠀⠀⠕⠂⠀⠉⢿⣿⣿⡄⠀⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠿⣿⠿⠟⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⡅⠄⠀⠀⠀⣰⡗⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣤⣤⣤⣶⣆⠀⣾⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⢰⡻⣿⣿⣿⣿⣷⠀⠀⡇⢀⣿⢡⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⣀⣀⣄⣴⣦⣼⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⠀⠀⠀⠸⢿⣿⣿⣿⣿⣾⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⣼⣿⣌⠻⡻⣻⣿⡅⠀⠐⢸⠇⠀⡤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣾⣿⣿⣿⣿⣿⡿⠟⠻⣿⡇⠀⠀⠀⠀⣀⣀⣤⣴⣶⣶⡄⠀⠀⠀⣴⣦⣶⡄⢀⡖⠀⡀⣠⣾⣿⠀⠀⠀⠀⠀⠀⠙⣟⠛⣻⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠐⣿⣿⣿⣷⣮⣓⠗⣿⡁⠀⠈⠀⠀⢉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⢿⣿⣿⣿⣿⣿⣿⣿⡛⠋⠋⠻⣿⡿⢿⠟⠢⠀⠀⣿⡇⠀⠀⠐⣿⣿⣿⣿⠿⠿⠿⠃⡀⠀⠀⠈⣿⣿⣧⣾⣿⣿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣄⡀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣷⣮⣅⠀⠁⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠨⢻⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⠇⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠈⠀⠀⠀⠻⢿⣿⣿⣿⠿⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣦⣤⣄⠀]],
          [[⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⢐⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⢀⣾⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⠟⠋⠉⠛⠻⢿⣿⣿⣿⣿⣿⣿⣿⣧]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣷⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢾⢛⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣀⣤⣠⣴⣾⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣶⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠃⠀⠀⠀⠀⠀⠀⠈⠉⠛⠋⠙⠛⠋⠁]],
          [[⠀⠄⠀⠀⠀⠀⠀⠀⠀⠈⠛⢿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣆⡀⠀⠀⣰⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣵⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠻⢿⣿⣿⣿⠟⠛⠙⠻⢿⣿⣿⣿⣿⣿⡟⠀⣠⣤⣶⣾⠧⠀⠀⢴⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⢿⣿⣶⣾⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣦⡂⣠⡤⠀⠀⠀⠀⠉⠀⠈⠉⠘⠁⠀⠀⢀⣀⠐⣿⣿⣿⣿⡿⠀⣼⣿⣿⣿⣷⠀⠀⢰⣿⠁⠀⠀⠀⣾⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⣄⡀⠀⠀⢀⣠⣤⣤⣤⣤⠀⠀⠀⠻⣿⣿⣿⣿⣿⣧⣿⣿⣷⠀⡀⠀⠀⢠⡖⠀⠀⢀⡀⣀⣰⣿⣿⣿⣿⣿⡿⠁⣼⣿⣿⣿⣿⠟⠁⢀⣾⣷⠀⠀⣠⣼⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢾⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⢹⣇⠀⠠⠼⣿⣿⣿⣷⣶⣦⣤⡀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣯⢄⠀⠀⣸⣷⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⠛⠿⠿⠟⠁⠀⢀⣾⣿⣿⢤⣾⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⢸⣿⣷⣄⠘⠻⢻⣿⣿⣿⡿⠿⢷⡀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⡦⡄⠀⣿⣿⡿⠿⠿⢿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣾⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠃⣻⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⣸⣿⣿⣿⡄⠀⠙⠛⠋⠉⠀⠀⠈⠣⠀⠀⠑⣿⣿⣿⣿⣿⣿⢯⣿⡷⢀⡿⠁⠀⠀⠀⢰⣿⣿⣿⣿⡟⠀⢀⣿⠄⠀⠠⣀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠈⠻⠿⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⢀⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⣿⣿⣿⣿⣿⣿⣿⣿⣼⣷⠦⢄⣒⢀⣰⣿⣿⡿⠋⠀⠀⠀⡿⠀⠐⢿⣷⣤⣼⣿⣿⣿⣿⢻⡿⣿⣿⣻⢿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⣸⣿⣿⣿⣿⣿⣿⣧⠄⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠙⠻⢿⣿⣿⣿⣿⣿⠟⠻⠻⠛⠛⠋⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⢁⣿⣿⣿⣿⣿⣿⠃⠈⠁⢿⠿⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡄⠀⠀⠀⠀⠘⠛⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⢰⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣽⠏⢠⡾⠀⢔⠦⣤⣄⣹⣟⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⢀⣿⣿⣿⣿⣿⣿⣌⣤⣴⣾⢗⡀⠀⠀⠀⠈⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠃⠀⢺⣿⡿⠃⠀⣾⣿⡿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⢸⣿⣿⣿⣿⣿⣉⣽⣁⣿⠻⢸⠇⠀⢀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠚⠀⡁⠀⠈⢿⠟⠛⣿⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠻⠏⣿⣿⢛⠎⠙⢽⣿⠀⡎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣺⢄⢠⣿⣿⡟⠿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠙⢿⡈⣷⡇⢺⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠟⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⠀⠀⠀⠀⠀⠀⠉⠁⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        }

        dashboard.section.buttons.val = {
          -- dashboard.button("e", "   New file",       ":ene <BAR> startinsert <CR>"),
          dashboard.button('f', '   Find file', ':Telescope find_files<CR>'),
          dashboard.button('g', '󰱼   Find word', ':Telescope live_grep<CR>'),
          dashboard.button('r', '󰈚   Recent', ':Telescope oldfiles<CR>'),
          dashboard.button(
            'o',
            '󰏫   Obsidian Find file',
            ':lua vim.cmd([[cd ~/Google Drive/My Drive/Memo]])<CR>:ObsidianQuickSwitch<CR>'
          ),
          dashboard.button(
            'O',
            '󰏫   Obsidian new file',
            ':lua vim.cmd([[cd ~/Google Drive/My Drive/Memo]])<CR>:ObsidianNew<CR>'
          ),
          dashboard.button('i', '   Edit init.lua', ':e $MYVIMRC <CR>'),
          dashboard.button('z', '   Edit .zshrc', ':e ~/.zshrc <CR>'),
          dashboard.button('w', '   Edit .wezterm.lua', ':e ~/.wezterm.lua <CR>'),
          dashboard.button('s', '   Edit sheldon config', ':e ~/.config/sheldon/plugins.toml <CR>'),
          dashboard.button('m', '󱌣   Mason', ':Mason<CR>'),
          dashboard.button('l', '󰒲   Lazy', ':Lazy<CR>'),
          dashboard.button('q', '   Quit NVIM', ':qa<CR>'),
        }

        alpha.setup(dashboard.opts)

        vim.api.nvim_create_autocmd('User', {
          callback = function()
            local stats = require('lazy').stats()
            local ms = math.floor(stats.startuptime * 100) / 100
            dashboard.section.footer.val = '⚡ Lazy '
              .. stats.loaded
              .. '/'
              .. stats.count
              .. ' plugins loaded in '
              .. ms
              .. 'ms'
            pcall(vim.cmd.AlphaRedraw)
          end,
        })
      end,
    },

    -- スクリーンセーバー
    {
      'folke/drop.nvim',
      event = 'VeryLazy',
      opts = {
        theme = 'auto',
        max = 50,
        screensaver = 1000 * 60 * 30, -- 30 minutes
      },
    },

    -- ステータスバー
    {
      'nvim-lualine/lualine.nvim',
      dependencies = {
        'linrongbin16/lsp-progress.nvim',
        'AndreM222/copilot-lualine',
        'uloco/bluloco.nvim',
      },
      event = 'VimEnter', -- 画面がちらつく
      config = function()
        require('lsp-progress').setup {}
        local lualine = require 'lualine'
        local theme_colors = {
          blue = '#193b73',
          cyan = '#79dac8',
          black = '#0a0a06',
          white = '#c6c6c6',
          red = '#ff5189',
          violet = '#d183e8',
          grey = '#303030',
          caloriemate = '#fbc114',
        }

        local bubbles_theme = {
          normal = {
            a = { fg = theme_colors.white, bg = theme_colors.grey },
            b = { fg = theme_colors.white, bg = theme_colors.blue, gui = 'bold' },
            c = { fg = theme_colors.white },
            x = { fg = theme_colors.white },
            y = { fg = theme_colors.black, bg = theme_colors.caloriemate },
            z = { fg = theme_colors.white, bg = theme_colors.grey, gui = 'bold' },
          },

          -- insert = { a = { fg = colors.black, bg = colors.blue } },
          -- visual = { a = { fg = colors.black, bg = colors.cyan } },
          -- replace = { a = { fg = colors.black, bg = colors.red } },

          inactive = {
            a = { fg = theme_colors.white, bg = theme_colors.black },
            b = { fg = theme_colors.white, bg = theme_colors.black },
            c = { fg = theme_colors.white },
          },
        }

        local config = {
          options = {
            disabled_filetypes = {
              statusline = { 'alpha' },
            },
            theme = bubbles_theme,
            component_separators = '',
            section_separators = { right = '', left = '' },
          },
          sections = {
            lualine_a = {
              {
                function()
                  return '󰩃'
                end,
                padding = { left = 2, right = 3 },
                color = function()
                  local evil_colors = {
                    bg = '#1c1f24',
                    fg = '#abb2bf',
                    yellow = '#d19a66',
                    cyan = '#2aa198',
                    darkblue = '#1c1f24',
                    green = '#98c379',
                    orange = '#e06c75',
                    violet = '#a9a1e1',
                    magenta = '#c678dd',
                    blue = '#61afef',
                    red = '#e06c75',
                  }

                  -- auto change color according to neovims mode
                  local mode_color = {
                    n = evil_colors.blue,
                    i = evil_colors.green,
                    v = evil_colors.red,
                    [''] = evil_colors.red,
                    V = evil_colors.red,
                    c = evil_colors.magenta,
                    no = evil_colors.blue,
                    s = evil_colors.orange,
                    S = evil_colors.orange,
                    [''] = evil_colors.orange,
                    ic = evil_colors.yellow,
                    R = evil_colors.violet,
                    Rv = evil_colors.violet,
                    cv = evil_colors.blue,
                    ce = evil_colors.blue,
                    r = evil_colors.cyan,
                    rm = evil_colors.cyan,
                    ['r?'] = evil_colors.cyan,
                    ['!'] = evil_colors.blue,
                    t = evil_colors.blue,
                  }
                  return { fg = mode_color[vim.fn.mode()] }
                end,
              },
            },
            lualine_b = {
              {
                'branch',
                icon = ' ',
                padding = { left = 1, right = 1 },
              },
              {
                'filename',
                path = 1, -- 1: Relative path
                file_status = false,
                separator = { right = '' },
              },
            },
            lualine_c = {
              "'%='",
              {
                'diff',
                symbols = { added = '  ', modified = '  ', removed = '  ' },
                separator = ' ',
              },
              {
                'diagnostics',
                sources = { 'nvim_diagnostic' },
                symbols = { error = '  ', warn = '  ', info = '  ', hint = '  ' },
              },
            },
            lualine_x = {
              function()
                return require('lsp-progress').progress {
                  format = function(messages)
                    local active_clients = vim.lsp.get_clients()
                    local client_count = #active_clients
                    if #messages > 0 then
                      return ' LSP:' .. client_count .. ' ' .. table.concat(messages, ' ')
                    end
                    if #active_clients <= 0 then
                      return ' LSP:' .. client_count
                    else
                      local client_names = {}
                      for _, client in ipairs(active_clients) do
                        if client and client.name ~= '' then
                          table.insert(client_names, '[' .. client.name .. ']')
                        end
                      end
                      return ' LSP:' .. client_count .. ' ' .. table.concat(client_names, ' ')
                    end
                  end,
                }
              end,
            },
            lualine_y = {
              {
                'copilot',
                symbols = {
                  -- spinners = require("copilot-lualine.spinners").moon
                  -- https://github.com/AndreM222/copilot-lualine/blob/main/lua/copilot-lualine/spinners.lua
                  spinners = {
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                  },
                },
                separator = { left = '' },
                padding = { left = 1, right = 2 },
              },
            },
            lualine_z = {
              {
                'filetype',
                icon_only = true,
                padding = { left = 2, right = 1 },
              },
              {
                'filetype',
                icons_enabled = false,
                padding = { left = 0, right = 2 },
              },
            },
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
          },
        }
        lualine.setup(config)
      end,
    },

    -- ウィンドウサイズ変更
    {
      'simeji/winresizer',
      event = 'VeryLazy',
    },

    -- スムーススクロール
    {
      'karb94/neoscroll.nvim',
      event = 'VeryLazy',
      config = function()
        local neoscroll = require 'neoscroll'
        neoscroll.setup {
          mappings = {
            '<C-u>',
            '<C-d>',
            '<C-b>',
            '<C-f>',
            -- "<C-y>",
            -- "<C-e>", -- use simeji/winresizer
            -- "zt",
            -- "zz",
            -- "zb",
          },
          easing = 'sine',
          hide_cursor = true,
          performance_mode = true,
        }
        local keymap = {
          ['<C-u>'] = function()
            neoscroll.ctrl_u { duration = 50 }
          end,
          ['<C-d>'] = function()
            neoscroll.ctrl_d { duration = 50 }
          end,
          ['<C-b>'] = function()
            neoscroll.ctrl_b { duration = 120 }
          end,
          ['<C-f>'] = function()
            neoscroll.ctrl_f { duration = 120 }
          end,
        }

        local modes = { 'n', 'v', 'x' }
        for key, func in pairs(keymap) do
          vim.keymap.set(modes, key, func)
        end
      end,
    },

    -- スクロールバー
    {
      'petertriho/nvim-scrollbar',
      event = 'VeryLazy',
      config = function()
        require('scrollbar').setup {
          throttle_ms = 1000,
          hide_if_all_visible = true,
          show_in_active_only = true,
          handle = { color = '#006df2' },
          excluded_buftypes = {
            'terminal',
          },
          excluded_filetypes = {
            'prompt',
            'dropbar_menu',
            'alpha',
          },
        }
      end,
    },

    -- 設定の切り替え
    {
      'gregorias/toggle.nvim',
      version = '2.0',
      event = { 'VeryLazy' },
      dependencies = {
        'nvim-telescope/telescope.nvim',
      },
      config = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local toggle = require 'toggle'
        toggle.register(
          'i',
          -- Disables or enables inlay hints for the current buffer.
          toggle.option.NotifyOnSetOption(toggle.option.OnOffOption {
            name = 'inlay hints',
            get_state = function()
              return vim.lsp.inlay_hint.is_enabled {}
            end,
            set_state = function(new_value)
              vim.lsp.inlay_hint.enable(new_value, {})
            end,
          }),
          { buffer = bufnr }
        )
        toggle.setup {
          keymaps = {
            toggle_option_prefix = 'to',
            previous_option_prefix = 'to[',
            next_option_prefix = 'to]',
            status_dashboard = 'tog',
          },
          keymap_registry = require('toggle.keymap').keymap_registry(),
          notify_on_set_default_option = true,
        }
      end,
    },

    -- winbar
    {
      'Bekaboo/dropbar.nvim',
      dependencies = {
        'nvim-telescope/telescope-fzf-native.nvim',
      },
      event = 'VeryLazy',
      config = function()
        require('dropbar').setup {
          background = false,
        }
      end,
    },

    -- LineLength 80 に色を付ける
    -- vim.opt.colorcolumn = "80"
    {
      'm4xshen/smartcolumn.nvim',
      event = 'VeryLazy',
      opts = {
        disabled_filetypes = {
          'alpha',
          'dropbar_menu',
          'NvimTree',
          'DiffviewFileHistory',
          'DiffviewFiles',
          'lazy',
          'mason',
        },
      },
    },

    -- コメントアウト
    {
      'numToStr/Comment.nvim',
      dependencies = {
        'JoosepAlviste/nvim-ts-context-commentstring',
      },
      event = 'VeryLazy',
      config = function()
        require('Comment').setup {
          pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        }
      end,
    },

    -- 括弧
    {
      'kylechui/nvim-surround',
      event = 'VeryLazy',
      config = function()
        require('nvim-surround').setup {
          keymaps = {
            insert = '<C-g>s',
            insert_line = '<C-g>S',
            normal = 'gs',
            normal_cur = 'gss',
            normal_line = 'gS',
            normal_cur_line = 'gSS',
            visual = 'S',
            visual_line = 'gS',
            delete = 'ds',
            change = 'cs',
          },
        }
      end,
    },

    -- ペア
    {
      'windwp/nvim-autopairs',
      event = 'VeryLazy',
      config = true,
    },

    -- HTML and JSX タグペア
    {
      'windwp/nvim-ts-autotag',
      event = 'VeryLazy',
      config = function()
        require('nvim-ts-autotag').setup {
          opts = {
            enable_close = true, -- Auto close tags
            enable_rename = true, -- Auto rename pairs of tags
            enable_close_on_slash = false, -- Auto close on trailing </
          },
        }
      end,
    },

    -- EditorConfig
    {
      'editorconfig/editorconfig-vim',
      event = 'VeryLazy',
    },

    -- Incremental Search
    {
      'kevinhwang91/nvim-hlslens',
      event = 'VeryLazy',
      config = function()
        require('hlslens').setup()
      end,
    },

    -- 置換
    {
      'MagicDuck/grug-far.nvim',
      event = 'VeryLazy',
      keys = {
        {
          mode = { 'n', 'o', 'x' },
          '<C-/>',
          "<cmd>lua require('grug-far').grug_far({ prefills = { search = vim.fn.expand('<cword>'), paths = vim.fn.expand('%') } })<CR>",
        },
      },
      config = function()
        require('grug-far').setup {
          windowCreationCommand = 'rightbelow 120vnew',
        }
      end,
    },

    -- w, e, b 移動の最適化
    {
      'chrisgrieser/nvim-spider',
      event = 'VeryLazy',
      keys = {
        {
          mode = { 'n', 'o', 'x' },
          'w',
          "<cmd>lua require('spider').motion('w')<CR>",
        },
        {
          mode = { 'n', 'o', 'x' },
          'e',
          "<cmd>lua require('spider').motion('e')<CR>",
        },
        {
          mode = { 'n', 'o', 'x' },
          'b',
          "<cmd>lua require('spider').motion('b')<CR>",
        },
      },
      config = function()
        require('spider').setup {
          skipInsignificantPunctuation = true,
          consistentOperatorPending = false,
          subwordMovement = false, -- ignore camelCase, snake_case
          customPatterns = {},
        }
      end,
    },

    -- カーソルジャンプ
    {
      'phaazon/hop.nvim',
      branch = 'v2',
      event = 'VeryLazy',
      config = function()
        require('hop').setup { keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }
        vim.keymap.set('n', 'ff', ':HopWordCurrentLine<CR>', keymap_opts)
        vim.keymap.set('n', 'fw', ':HopWord<CR>', keymap_opts)
        vim.keymap.set('n', 'fp', ':HopPattern<CR>', keymap_opts)
        vim.keymap.set('n', 'fl', ':HopLine<CR>', keymap_opts)
        vim.api.nvim_set_hl(0, 'HopNextKey', { fg = '#fbc114' })
        vim.api.nvim_set_hl(0, 'HopNextKey1', { fg = '#fbc114' })
        vim.api.nvim_set_hl(0, 'HopNextKey2', { fg = '#fbc114' })
        vim.api.nvim_set_hl(0, 'HopUnmatched', { fg = '#787d8f' })
      end,
    },

    -- 括弧位置ハイライト
    {
      'utilyre/sentiment.nvim',
      event = 'VeryLazy',
      config = function()
        require('sentiment').setup {}
        vim.api.nvim_set_hl(0, 'MatchParen', { bg = '#4c566a', fg = '#88c0d0' })
      end,
    },

    -- カーソル位置ハイライト
    {
      'RRethy/vim-illuminate',
      event = 'VeryLazy',
      config = function()
        require('illuminate').configure {
          providers = {
            'lsp',
            'treesitter',
            'regex',
          },
          delay = 500,
          filetype_overrides = {},
          filetypes_denylist = {
            'dropbar_menu',
            'NvimTree',
            'DiffviewFileHistory',
            'DiffviewFiles',
            'lazy',
            'mason',
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
          case_insensitive_regex = false,
        }
      end,
    },

    -- コピーハイライト
    {
      'machakann/vim-highlightedyank',
      event = 'VeryLazy',
    },

    -- クリップボード履歴
    {
      'ptdewey/yankbank-nvim',
      event = 'VeryLazy',
      config = function()
        require('yankbank').setup()
        vim.keymap.set('n', '<C-p>', '<cmd>YankBank<CR>', keymap_opts)
      end,
    },

    -- 引数の入れ替え g> g< gs gsl gsh gsk gsj
    {
      'machakann/vim-swap',
      event = 'VeryLazy',
    },

    -- テキストの分割と結合
    {
      'echasnovski/mini.splitjoin',
      event = { 'BufRead', 'BufNewFile' },
      config = function()
        require('mini.splitjoin').setup {
          mappings = {
            toggle = 'gss',
            split = '',
            join = '',
          },
        }
      end,
    },

    -- 選択したテキストの移動
    {
      'echasnovski/mini.move',
      event = 'VeryLazy',
      opts = {
        mappings = {
          -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
          left = '<M-h>',
          right = '<M-l>',
          down = '<M-j>',
          up = '<M-k>',

          -- Move current line in Normal mode
          line_left = '<M-h>',
          line_right = '<M-l>',
          line_down = '<M-j>',
          line_up = '<M-k>',
        },
        options = {
          reindent_linewise = true,
        },
      },
    },

    -- Visual モードで空白文字を表示
    {
      'mcauley-penney/visual-whitespace.nvim',
      event = { 'BufRead', 'BufNewFile' },
      config = true,
      opts = {
        highlight = { link = 'Visual' },
        space_char = '·',
        tab_char = '→',
        nl_char = '↲',
        cr_char = '←',
      },
    },

    -- インデント表示、Textobjects
    {
      'echasnovski/mini.indentscope',
      event = { 'BufRead', 'BufNewFile' },
      config = function()
        require('mini.indentscope').setup {
          options = {
            try_as_border = false,
            indent_at_cursor = true,
          },
          draw = {
            delay = 500,
            -- animation = require("mini.indentscope").gen_animation.none(),
          },
          mappings = {
            object_scope = 'ii',
            object_scope_with_border = 'ai',
            goto_top = '[i',
            goto_bottom = ']i',
          },
          -- symbol = "󰍳",
        }

        vim.api.nvim_create_autocmd('FileType', {
          pattern = {
            'help',
            'alpha',
            'Trouble',
            'mason',
            'notify',
            'toggleterm',
          },
          callback = function()
            vim.b.miniindentscope_disable = true
          end,
        })
      end,
    },

    -- 通知
    {
      'echasnovski/mini.notify',
      event = 'VeryLazy',
      keys = {
        {
          mode = { 'n', 'o', 'x' },
          '<Leader>l',
          '<cmd>tabnew | lua MiniNotify.show_history()<CR>',
        },
      },
      config = function()
        require('mini.notify').setup {
          lsp_progress = {
            enable = false,
          },
        }

        vim.notify = require('mini.notify').make_notify {
          ERROR = { duration = 5000 },
          WARN = { duration = 5000 },
          INFO = { duration = 5000 },
        }
      end,
    },

    -- カラーハイライト
    {
      'NvChad/nvim-colorizer.lua',
      event = 'VeryLazy',
      opts = {
        filetypes = { '*' },
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = false, -- "Name" codes like Blue or blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          AARRGGBB = true, -- 0xAARRGGBB hex codes
          rgb_fn = false, -- CSS rgb() and rgba() functions
          hsl_fn = false, -- CSS hsl() and hsla() functions
          css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = 'virtualtext', -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = false, -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          sass = { enable = false, parsers = { 'css' } }, -- Enable sass colors
          virtualtext = '',
          -- update color values even if buffer is not focused
          -- example use: cmp_menu, cmp_docs
          always_update = false,
        },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = {},
      },
    },

    -- ログに色付け
    {
      'fei6409/log-highlight.nvim',
      ft = { 'log' },
      -- event = 'VeryLazy',
      config = function()
        -- ログのバッファだけ背景色を変える
        vim.api.nvim_create_autocmd('FileType', {
          pattern = { 'log' },
          callback = function()
            vim.cmd 'highlight LogNormal guibg=#282828 ctermbg=darkgray'
            vim.cmd 'setlocal winhighlight=Normal:LogNormal'
          end,
        })
      end,
    },

    -- ファイルツリー
    {
      'nvim-tree/nvim-tree.lua',
      dependencies = {
        'b0o/nvim-tree-preview.lua',
        'nvim-lua/plenary.nvim',
      },
      event = 'VeryLazy',
      config = function()
        local preview = require 'nvim-tree-preview'
        local function on_attach(bufnr)
          local api = require 'nvim-tree.api'
          local function opts(desc)
            return {
              desc = 'nvim-tree: ' .. desc,
              buffer = bufnr,
              noremap = true,
              silent = true,
              nowait = true,
            }
          end
          api.config.mappings.default_on_attach(bufnr)
          vim.keymap.set('n', 'x', api.node.run.system, opts 'Open System')
          vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')
          vim.keymap.set('n', '=', api.tree.change_root_to_node, opts 'CD')
          vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts 'Dir Up')
          vim.keymap.set('n', 'l', api.node.open.edit, opts 'Edit')
          vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts 'Close Node')
          vim.keymap.set('n', 's', '', opts '')
          vim.keymap.set('n', 'sl', '<c-w>l', opts '')
          vim.keymap.set('n', 'P', preview.watch, opts 'Preview (Watch)')
          vim.keymap.set('n', '<Esc>', preview.unwatch, opts 'Close Preview/Unwatch')
          vim.keymap.set('n', '<Tab>', function()
            local ok, node = pcall(api.tree.get_node_under_cursor)
            if ok and node then
              if node.type == 'directory' then
                api.node.open.edit()
              else
                preview.watch()
              end
            end
          end, opts 'Preview')
        end

        preview.setup {
          keymaps = {
            ['<Esc>'] = { action = 'close', unwatch = true },
          },
          min_width = 60,
          min_height = 15,
          max_width = 160,
          max_height = 40,
          wrap = false, -- Whether to wrap lines in the preview window
          border = 'rounded', -- Border style for the preview window
        }

        require('nvim-tree').setup {
          on_attach = on_attach,
          view = {
            signcolumn = 'yes',
            float = {
              enable = true,
              open_win_config = {
                height = 65,
                width = 45,
              },
            },
          },
          update_focused_file = {
            enable = true,
            update_cwd = false,
          },
          diagnostics = {
            enable = true,
            icons = {
              hint = ' ',
              info = ' ',
              warning = ' ',
              error = ' ',
            },
            show_on_dirs = true,
          },
          renderer = {
            group_empty = true,
            highlight_git = true,
            highlight_opened_files = 'name',
            icons = {
              git_placement = 'signcolumn',
              modified_placement = 'signcolumn',
              glyphs = {
                git = {
                  deleted = '',
                  unstaged = '',
                  untracked = '',
                  staged = '',
                  unmerged = '',
                  renamed = '»',
                  ignored = '◌',
                },
              },
            },
          },
          filters = {
            dotfiles = false,
          },
          git = {
            enable = true,
            ignore = false,
          },
        }
        vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', keymap_opts)
      end,
    },

    -- nvim-tree でファイル名変更した場合などに自動で更新
    {
      'antosha417/nvim-lsp-file-operations',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-tree.lua',
      },
      event = 'VeryLazy',
      config = function()
        require('lsp-file-operations').setup()
      end,
    },

    -- Git
    {
      'kdheepak/lazygit.nvim',
      cmd = {
        'LazyGit',
        'LazyGitConfig',
        'LazyGitCurrentFile',
        'LazyGitFilter',
        'LazyGitFilterCurrentFile',
      },
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
      keys = {
        { '<Leader>gl', '<cmd>LazyGit<CR>', desc = 'LazyGit' },
      },
    },

    -- Git 差分表示
    {
      'sindrets/diffview.nvim',
      event = 'VeryLazy',
      keys = {
        {
          mode = 'n',
          '<Leader>gd',
          '<cmd>DiffviewOpen<CR>',
        },
        {
          mode = 'n',
          '<Leader>gh',
          '<cmd>DiffviewFileHistory<CR>',
        },
        {
          mode = 'n',
          '<Leader>gc',
          '<cmd>DiffviewFileHistory %<CR>',
        },
      },
    },

    -- Git Blame
    {
      'lewis6991/gitsigns.nvim',
      event = 'VeryLazy',
      keys = {
        {
          mode = 'n',
          '<Leader>g',
          '<cmd>Gitsigns blame<CR>',
        },
      },
      config = function()
        require('gitsigns').setup {
          signs = {
            add = { text = '┃' },
            change = { text = '┃' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
            untracked = { text = '┆' },
          },
          signs_staged = {
            add = { text = '┃' },
            change = { text = '┃' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
            untracked = { text = '┆' },
          },
          signs_staged_enable = true,
          signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
          numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
          linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
          word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
          watch_gitdir = {
            follow_files = true,
          },
          auto_attach = true,
          attach_to_untracked = false,
          current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
          current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 500,
            ignore_whitespace = false,
            virt_text_priority = 100,
          },
          current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
          sign_priority = 6,
          update_debounce = 100,
          status_formatter = nil, -- Use default
          max_file_length = 10000, -- Disable if file is longer than this (in lines)
          preview_config = {
            -- Options passed to nvim_open_win
            border = 'single',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1,
          },
        }
        -- スクロールバーにも表示
        require('scrollbar.handlers.gitsigns').setup()
      end,
    },

    -- コマンドのデザイン
    {
      'Sam-programs/cmdline-hl.nvim',
      event = { 'BufReadPre', 'BufNewFile' }, -- 画面がちらつく
      config = function()
        local cmdline_hl = require 'cmdline-hl'
        cmdline_hl.setup {
          type_signs = {
            [':'] = { '   ', 'Title' },
            ['/'] = { '   ', 'Title' },
            ['?'] = { '   ', 'Title' },
            ['='] = { '   ', 'Title' },
          },
          custom_types = {
            ['lua'] = { icon = '    ', icon_hl = 'Title', lang = 'lua', show_cmd = true },
            ['='] = { pat = '=(.*)', lang = 'lua', show_cmd = true },
            ['help'] = { icon = '  ? ', show_cmd = true },
            ['substitute'] = { pat = '%w(.*)', lang = 'regex', show_cmd = true },
          },
          aliases = {},
          input_hl = 'Title',
          input_format = function(input)
            return input
          end,
          range_hl = 'Constant',
          ghost_text = false,
          ghost_text_hl = 'Comment',
          inline_ghost_text = false,
          -- ghost_text_provider = require("cmdline-hl.ghost_text").history,
        }
      end,
    },

    -- コードハイライト
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      event = 'VeryLazy',
      init = function(plugin)
        -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
        -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
        -- no longer trigger the **nvim-treeitter** module to be loaded in time.
        -- Luckily, the only thins that those plugins need are the custom queries, which we make available
        -- during startup.
        -- CODE FROM LazyVim (thanks folke!) https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
        require('lazy.core.loader').add_to_rtp(plugin)
        pcall(require, 'nvim-treesitter.query_predicates')
      end,
      config = function()
        require('nvim-treesitter.configs').setup {
          ensure_installed = {
            'gitignore',
            'git_config',
            'lua',
            'vim',
            'vimdoc',
            'dart',
            'graphql',
            'bash',
            'swift',
            'objc',
            'kotlin',
            'java',
            'go',
            'printf',
            'regex',
            'json',
            'json5',
            'javascript',
            'typescript',
            'svelte',
            'vue',
            'astro',
            'terraform',
            'css',
            'html',
            'markdown',
            'markdown_inline',
            'yaml',
            'toml',
            'xml',
          },
          sync_install = false,
          auto_install = false,
          highlight = {
            enable = true,
            disable = function(_, buf)
              -- log は treesitter によるハイライトはしない
              if vim.bo[buf].filetype == 'log' then
                return false
              end
              local max_filesize = 100 * 1024 -- 100 KB
              local check_stats = vim.uv.fs_stat
              local ok, stats = pcall(check_stats, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                return true
              else
                return false
              end
            end,
            additional_vim_regex_highlighting = false,
          },
        }
      end,
    },

    -- クラス構造
    {
      'SmiteshP/nvim-navbuddy',
      dependencies = {
        'neovim/nvim-lspconfig',
        'SmiteshP/nvim-navic',
        'MunifTanjim/nui.nvim',
      },
      keys = {
        { '<Leader>s', '<cmd>Navbuddy<cr>', desc = 'nabuddy' },
      },
      event = 'VeryLazy',
      config = function()
        require('nvim-navbuddy').setup {
          window = {
            border = 'rounded',
            size = '80%',
            position = '50%',
            sections = {
              left = {
                size = '20%',
              },
              mid = {
                size = '30%',
              },
              right = {
                preview = 'always',
              },
            },
          },
          use_default_mappings = true,
          lsp = {
            auto_attach = true,
          },
        }
      end,
      -- opts = { lsp = { auto_attach = true } },
    },

    -- fzf ファイル・コマンド検索
    {
      'nvim-telescope/telescope.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        'nvim-telescope/telescope-ui-select.nvim',
        'nvim-telescope/telescope-media-files.nvim',
        'jonarrien/telescope-cmdline.nvim',
        'dimaportenko/telescope-simulators.nvim',
        'debugloop/telescope-undo.nvim',
      },
      event = 'VeryLazy',
      config = function()
        vim.keymap.set('n', '<C-o>', function()
          require('telescope.builtin').find_files {
            hidden = false,
            path_display = function(_, path)
              local tail = require('telescope.utils').path_tail(path)
              local relative_path = vim.fn.fnamemodify(path, ':.')
              return string.format('%s (%s)', tail, relative_path), { { { 1, #tail }, 'Constant' } }
            end,
          }
        end, keymap_opts)
        vim.keymap.set('n', '<C-S-O>', function()
          require('telescope.builtin').oldfiles {
            path_display = function(_, path)
              local tail = require('telescope.utils').path_tail(path)
              local relative_path = vim.fn.fnamemodify(path, ':.')
              return string.format('%s (%s)', tail, relative_path), { { { 1, #tail }, 'Constant' } }
            end,
          }
        end, keymap_opts)
        vim.keymap.set('n', '<C-g>', "<cmd>lua require('telescope.builtin').live_grep()<CR>", keymap_opts)
        -- vim.keymap.set(
        --   "n",
        --   "<C-x>",
        --   "<cmd>lua require('telescope.builtin').commands()<CR>",
        --   keymap_opts
        -- )
        -- vim.keymap.set(
        --   "n",
        --   "<C-m>",
        --   "<cmd>lua require('telescope.builtin').keymaps()<CR>",
        --   keymap_opts
        -- )
        vim.keymap.set('n', '<C-x>', '<cmd>Telescope simulators run<CR>', keymap_opts)
        vim.keymap.set('n', ':', ':Telescope cmdline<CR>', keymap_opts)
        vim.keymap.set('n', '?', ':Telescope current_buffer_fuzzy_find<CR>', keymap_opts)
        vim.keymap.set('n', '<Leader>r', function()
          require('telescope.builtin').lsp_references(require('telescope.themes').get_cursor {
            hide_preview = false,
            path_display = function(_, path)
              local tail = require('telescope.utils').path_tail(path)
              local relative_path = vim.fn.fnamemodify(path, ':.')
              return string.format('%s (%s)', tail, relative_path), { { { 1, #tail }, 'Constant' } }
            end,
            layout_config = {
              width = 160,
              height = 20,
            },
          })
        end, bufopsts)

        vim.api.nvim_create_user_command('Clear', function(_)
          vim.fn.histdel('cmd', -1)
        end, {})

        local telescope = require 'telescope'
        -- local builtin_schemes = require("telescope._extensions.themes").builtin_schemes
        telescope.setup {
          pickers = {
            -- current_buffer_fuzzy_find = { theme = "ivy" },
            find_files = {
              find_command = {
                'rg',
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--smart-case',
                '--trim',
                -- "--no-ignore",
                '--hidden',
                '--files',
                '--sortr=modified',
              },
            },
          },
          defaults = {
            initial_mode = 'insert',
            prompt_prefix = ' ',
            selection_caret = '󰁕 ',
            file_ignore_patterns = {
              '.git/HEAD',
              '.git/[^c][^o][^n][^f][^i][^g]', -- 除外するパターンの正規表現
              '.git/[^h][^o][^o][^k][^s]',
            },
            vimgrep_arguments = {
              'rg',
              '--color=never',
              '--no-heading',
              '--with-filename',
              '--line-number',
              '--column',
              '--smart-case',
              '--trim',
              -- "--no-ignore",
              '--hidden',
            },
            mappings = {
              n = {
                ['<C-q>'] = 'close',
              },
              i = {
                ['<C-q>'] = 'close',
                ['<Tab>'] = function(prompt_bufnr)
                  local action_state = require 'telescope.actions.state'
                  local actions = require 'telescope.actions'
                  local picker = action_state.get_current_picker(prompt_bufnr)
                  local prompt_win = picker.prompt_win
                  local previewer = picker.previewer
                  local bufnr = previewer.state.bufnr or previewer.state.termopen_bufnr
                  local winid = previewer.state.winid or vim.fn.bufwinid(bufnr)
                  vim.keymap.set('n', '<Tab>', function()
                    vim.cmd(string.format('noautocmd lua vim.api.nvim_set_current_win(%s)', prompt_win))
                  end, { buffer = bufnr })
                  vim.keymap.set('n', '<esc>', function()
                    actions.close(prompt_bufnr)
                  end, { buffer = bufnr })
                  vim.cmd(string.format('noautocmd lua vim.api.nvim_set_current_win(%s)', winid))
                end,
              },
            },
            extensions = {
              fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
              },
              cmdline = {
                picker = {
                  layout_config = {
                    width = 120,
                    height = 25,
                  },
                },
                mappings = {
                  complete = '<Tab>',
                  run_selection = '<C-CR>',
                  run_input = '<CR>',
                },
              },
              undo = {},
              media_files = {
                filetypes = { 'png', 'webp', 'jpg', 'jpeg' },
                find_cmd = 'rg',
              },
            },
            preview = {
              treesitter = true,
              mime_hook = function(filepath, bufnr, opts)
                local is_image = function(_)
                  local image_extensions = { 'png', 'jpg', 'jpeg', 'gif', 'ico', 'webp' } -- Supported image formats
                  local split_path = vim.split(filepath:lower(), '.', { plain = true })
                  local extension = split_path[#split_path]
                  return vim.tbl_contains(image_extensions, extension)
                end
                if is_image(filepath) then
                  local term = vim.api.nvim_open_term(bufnr, {})
                  local function send_output(_, data, _)
                    for _, d in ipairs(data) do
                      vim.api.nvim_chan_send(term, d .. '\r\n')
                    end
                  end
                  vim.fn.jobstart({
                    'viu',
                    '-w',
                    '100',
                    '-b',
                    filepath,
                  }, {
                    on_stdout = send_output,
                    stdout_buffered = true,
                    pty = true,
                  })
                else
                  require('telescope.previewers.utils').set_preview_message(
                    bufnr,
                    opts.winid,
                    'Binary cannot be previewed'
                  )
                end
              end,
            },
          },
        }
        telescope.load_extension 'fzf'
        telescope.load_extension 'ui-select'
        telescope.load_extension 'media_files'
        telescope.load_extension 'cmdline'
        telescope.load_extension 'undo'
        require('simulators').setup {
          android_emulator = true,
          apple_simulator = true,
        }
      end,
    },

    -- コードアクション、差分修正
    {
      'aznhe21/actions-preview.nvim',
      event = 'LspAttach',
      config = function()
        vim.keymap.set({ 'v', 'n' }, '<Leader>a', require('actions-preview').code_actions)
        require('actions-preview').setup {
          highlight_command = {
            -- require("actions-preview.highlight").delta(),
            -- require("actions-preview.highlight").diff_so_fancy(),
            -- require("actions-preview.highlight").diff_highlight(),
          },
          backend = { 'telescope' },
          telescope = require('telescope.themes').get_cursor {
            layout_config = {
              width = 160,
              height = 40,
            },
          },
        }
      end,
    },

    -- Diagnostics
    {
      'folke/trouble.nvim',
      event = 'VeryLazy',
      opts = {},
      keys = {
        {
          '<Leader>e',
          '<cmd>Trouble diagnostics toggle filter.buf=0<CR>',
          desc = 'Diagnostics (Trouble)',
        },
      },
    },

    -- Inline Diagnostics
    {
      'dgagn/diagflow.nvim',
      event = 'LspAttach',
      opts = {},
      config = function()
        require('diagflow').setup {
          enable = true,
          max_width = 120,
          max_height = 40,
          severity_colors = {
            error = 'DiagnosticFloatingError',
            warning = 'DiagnosticFloatingWarn',
            info = 'DiagnosticFloatingInfo',
            hint = 'DiagnosticFloatingHint',
          },
          format = function(diagnostic)
            return diagnostic.message
          end,
          gap_size = 1,
          scope = 'cursor',
          padding_top = 0,
          padding_right = 5,
          text_align = 'right',
          placement = 'top',
          inline_padding_left = 0,
          update_event = { 'DiagnosticChanged', 'BufReadPost' },
          toggle_event = {},
          show_sign = false,
          render_event = { 'DiagnosticChanged', 'CursorMoved' },
          border_chars = {
            top_left = '┌',
            top_right = '┐',
            bottom_left = '└',
            bottom_right = '┘',
            horizontal = '─',
            vertical = '│',
          },
          show_borders = false,
        }
      end,
    },

    -- Formatter
    {
      'stevearc/conform.nvim',
      event = 'VeryLazy',
      cmd = { 'ConformInfo' },
      keys = {
        {
          '<Leader>f',
          function()
            require('conform').format { async = true }
          end,
        },
      },
      config = function()
        vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
        require('conform').setup {
          -- format_on_save = { timeout_ms = 500 },
          formatters_by_ft = {
            ['*'] = { 'trim_whitespace', 'trim_newlines' },
            sh = { 'shfmt' },
            bash = { 'shfmt' },
            zsh = { 'shfmt' },
            lua = { 'stylua' },
            markdown = { 'prettierd' },
            json = { 'prettierd' },
            yaml = { 'prettierd' },
            toml = { 'dprint' },
            html = { 'prettierd' },
            css = { 'prettierd' },
            xml = { 'xmlformat' },
            vue = { 'prettierd' },
            svelte = { 'prettierd' },
            astro = { 'prettierd' },
            javascript = { 'eslint_d', 'prettierd' },
            javascriptreact = { 'eslint_d', 'prettierd' },
            typescript = { 'eslint_d', 'prettierd' },
            typescriptreact = { 'eslint_d', 'prettierd' },
            java = { 'google-java-format' },
            kotlin = { 'ktlint' },
            dart = { 'dart_format' },
            go = { 'gofmt', 'goimports' },
            graphql = { 'prettierd' },
            swift = { 'swiftformat' },
          },
          formatters = {
            dprint = {
              prepend_args = function(self, ctx)
                ---@diagnostic disable-next-line: param-type-mismatch
                if not self:cwd(ctx) then
                  vim.notify 'Falling back to global dprint config'
                  return {
                    '--config',
                    vim.fn.expand '~/.config/dprint.json',
                  }
                end
                return {}
              end,
            },
          },
        }
      end,
    },

    -- Linter
    {
      'mfussenegger/nvim-lint',
      event = 'VeryLazy',
      config = function()
        local lint = require 'lint'
        lint.linters_by_ft = {
          javascript = { 'eslint_d', 'typos' },
          typescript = { 'eslint_d', 'typos' },
          javascriptreact = { 'eslint_d', 'typos' },
          typescriptreact = { 'eslint_d', 'typos' },
          css = { 'stylelint', 'typos' },
          sh = { 'shellcheck', 'typos' },
          lua = { 'selene', 'typos' },
          -- markdown = { 'markdownlint', 'typos' }, -- stop vale
          json = { 'jsonlint', 'typos' },
          yaml = { 'yamllint', 'actionlint', 'typos' },
          terraform = { 'tflint', 'typos' },
          go = { 'golangcilint', 'typos' },
          swift = { 'swiftlint', 'typos' },
          kotlin = { 'ktlint', 'typos' },
          dart = { 'typos' },
        }
        -- for ft, _ in pairs(lint.linters_by_ft) do
        --   table.insert(lint.linters_by_ft[ft], 'typos')
        -- end

        vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost', 'InsertLeave' }, {
          -- https://github.com/syphar/dotfiles/blob/a60a9b6337499ab9b48398374ddda49331b3ecd6/.config/nvim/lua/dc/plugins/lint.lua#L32
          callback = function()
            if vim.bo.filetype == 'swift' then
              lint.try_lint 'swiftlint'
              return
            else
              local ctx = { filename = vim.api.nvim_buf_get_name(0) }
              ctx.dirname = vim.fn.fnamemodify(ctx.filename, ':h')

              if not lint.linters_by_ft[vim.bo.filetype] then
                return
              end

              local linters = vim.tbl_filter(function(name)
                local linter = lint.linters[name]

                assert(linter)
                assert(type(linter) == 'table')

                ---@diagnostic disable-next-line: undefined-field
                return not (linter.condition and not linter.condition(ctx))
              end, lint.linters_by_ft[vim.bo.filetype])

              if #linters > 0 then
                lint.try_lint(linters)
              end
            end
          end,
        })

        -- actionlint
        ---@diagnostic disable-next-line: undefined-field, inject-field
        lint.linters.actionlint.condition = function(ctx)
          return ctx.filename:find '.github'
        end

        -- selene
        lint.linters.selene.args = {
          '--config',
          function() -- find selene.toml file
            local conf =
              vim.fs.find({ 'selene.toml' }, { type = 'file', upward = true, path = vim.api.nvim_buf_get_name(0) })[1]
            if conf == nil then
              conf = vim.fn.expand('~/.config/selene.toml')[1]
            end
            return conf
          end,
          '--display-style',
          'json',
          '-',
        }
      end,
    },

    -- インラインターミナル
    {
      'akinsho/toggleterm.nvim',
      event = 'VeryLazy',
      keys = {
        { '<C-t>t', '<Cmd>ToggleTerm direction=float<CR>' },
        { '<C-t>f', '<Cmd>ToggleTerm direction=float<CR>' },
        { '<C-t>v', '<Cmd>ToggleTerm direction=vertical<CR>' },
        { '<C-t>h', '<Cmd>ToggleTerm direction=horizontal<CR>' },
      },
      opts = {
        open_mapping = '<C-t>',
        direction = 'float',
        float_opts = {
          winblend = 10,
          border = 'curved',
        },
      },
    },

    -- バッファ操作
    {
      'j-morano/buffer_manager.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
      event = { 'BufReadPre', 'BufNewFile' },
      opts = {
        -- order_buffers = "lastused",
        width = 0.4,
        height = 0.3,
      },
      keys = {
        {
          '[]',
          function()
            require('buffer_manager.ui').toggle_quick_menu()
          end,
        },
      },
    },
    {
      'willothy/nvim-cokeline',
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
      event = { 'BufReadPre', 'BufNewFile' },
      keys = {
        { '[[', '<Plug>(cokeline-focus-prev)' },
        { '\\[[', '<Plug>(cokeline-switch-prev)' },
        { ']]', '<Plug>(cokeline-focus-next)' },
        { '\\]]', '<Plug>(cokeline-switch-next)' },
        { '\\\\', '<cmd>bd<CR>' },
        {
          '\\][',
          ':lua for _, buf in ipairs(vim.api.nvim_list_bufs()) do if buf ~= vim.api.nvim_get_current_buf() then vim.api.nvim_buf_delete(buf, {force = true}) end end<CR>',
        },
      },
      config = function()
        local get_hex = require('cokeline.hlgroups').get_hl_attr
        -- local mappings = require 'cokeline/mappings'

        local comments_fg = get_hex('Comment', 'fg')
        local errors_fg = get_hex('DiagnosticError', 'fg')
        local warnings_fg = get_hex('DiagnosticWarn', 'fg')

        -- local active_fg = get_hex("Normal", "fg")
        local active_fg = '#282828'
        -- local active_bg = get_hex("ColorColumn", "bg")
        local active_bg = '#fbc114'
        -- local inactive_fg = get_hex("Comment", "fg")
        local inactive_fg = '#ffffff'
        -- local inactive_bg = get_hex("Normal", "bg")
        local inactive_bg = '#303030'
        local terminal_bg = '#282c34'

        local components = {
          margin = {
            text = ' ',
            bg = get_hex('Normal', 'bg'),
            truncation = { priority = 1 },
          },

          space = { text = ' ', truncation = { priority = 1 } },

          two_spaces = { text = '  ', truncation = { priority = 1 } },

          separator_left = {
            text = '',
            fg = function(buffer)
              return buffer.is_focused and active_bg or inactive_bg
            end,
            bg = terminal_bg,
          },

          separator_right = {
            text = '',
            fg = function(buffer)
              return buffer.is_focused and active_bg or inactive_bg
            end,
            bg = terminal_bg,
          },

          devicon = {
            text = function(buffer)
              return buffer.devicon.icon
            end,
            fg = function(buffer)
              return buffer.devicon.color
            end,
            truncation = { priority = 1 },
          },

          index = {
            text = function(buffer)
              return buffer.index .. ': '
            end,
            truncation = { priority = 1 },
          },

          unique_prefix = {
            text = function(buffer)
              return buffer.unique_prefix
            end,
            fg = comments_fg,
            italic = function(_)
              return true
            end,
            truncation = { priority = 3, direction = 'left' },
          },

          filename = {
            text = function(buffer)
              return buffer.filename
            end,
            underline = function(buffer)
              return buffer.diagnostics.errors ~= 0 and 'underline'
            end,
            bold = function(buffer)
              return buffer.is_focused
            end,
            italic = function(buffer)
              return not buffer.is_focused
            end,
            truncation = { priority = 2, direction = 'left' },
          },

          diagnostics = {
            text = function(buffer)
              return (buffer.diagnostics.errors ~= 0 and '  ' .. buffer.diagnostics.errors)
                or (buffer.diagnostics.warnings ~= 0 and '  ' .. buffer.diagnostics.warnings)
                or ''
            end,
            fg = function(buffer)
              return (buffer.diagnostics.errors ~= 0 and errors_fg)
                or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
                or nil
            end,
            truncation = { priority = 1 },
          },

          close_or_unsaved = {
            text = function(buffer)
              return buffer.is_modified and '󰆓 ' or ' '
            end,
            fg = function(buffer)
              return buffer.is_modified and warnings_fg or nil
            end,
            delete_buffer_on_left_click = true,
            truncation = { priority = 1 },
          },
        }

        require('cokeline').setup {
          default_hl = {
            fg = function(buffer)
              return buffer.is_focused and active_fg or inactive_fg
            end,
            bg = function(buffer)
              return buffer.is_focused and active_bg or inactive_bg
            end,
          },
          components = {
            components.margin,
            components.separator_left,
            components.space,
            components.devicon,
            components.space,
            components.unique_prefix,
            components.filename,
            components.diagnostics,
            components.space,
            components.close_or_unsaved,
            components.space,
            components.separator_right,
          },

          buffers = {
            filter_visible = function(buffer)
              return buffer.type ~= 'terminal' and buffer.type ~= 'quickfix' and buffer.filename ~= '[No Name]'
            end,
            filter_valid = function(buffer)
              return buffer.type ~= 'terminal' and buffer.type ~= 'quickfix' and buffer.filename ~= '[No Name]'
            end,
          },

          sidebar = {
            filetype = { 'NvimTree' },
            components = {
              {
                text = function(buf)
                  return buf.filetype
                end,
                fg = yellow,
                bg = function()
                  return get_hex('NvimTreeNormal', 'bg')
                end,
                bold = true,
              },
            },
          },
        }
      end,
    },

    -- タスクショートカット
    {
      'stevearc/overseer.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim',
        'nvim-telescope/telescope.nvim',
      },
      event = 'VeryLazy',
      config = function()
        local overseer = require 'overseer'

        -- Git
        overseer.register_template {
          name = 'tig status',
          builder = function()
            return {
              cmd = 'tig',
              args = { 'status' },
            }
          end,
        }

        overseer.register_template {
          name = 'git pull origin main',
          builder = function()
            return {
              cmd = 'git',
              args = { 'pull', 'origin', 'main' },
            }
          end,
        }
        overseer.register_template {
          name = 'chezmoi re-add',
          builder = function()
            return {
              cmd = 'chezmoi',
              args = { 're-add' },
            }
          end,
        }

        overseer.setup {
          strategy = 'toggleterm',
          -- quit_on_exit = "succss",
          dap = false,
        }
        vim.keymap.set('n', '<C-.>', '<cmd>OverseerRun<CR>', keymap_opts)
      end,
    },

    -- キー入力
    {
      'NStefan002/screenkey.nvim',
      event = 'VeryLazy',
      config = function()
        require('screenkey').setup {
          disable = {
            filetypes = {
              'alpha',
            },
          },
          win_opts = {
            title = 'Keys',
            width = 40,
            height = 1,
          },
          display_infront = { '*' },
          keys = {
            ['<leader>'] = '<Space>',
          },
        }
        vim.api.nvim_create_autocmd('BufAdd', {
          group = vim.api.nvim_create_augroup('AutostartScreenkey', {}),
          command = 'Screenkey toggle',
          desc = 'Autostart Screenkey on BufRead',
        })
      end,
    },

    -- Markdown プレビュー
    {
      'OXY2DEV/markview.nvim',
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'echasnovski/mini.icons',
      },
      ft = 'markdown',
      -- event = "VeryLazy",
    },

    -- Markdown テーブル整形
    {
      'Kicamon/markdown-table-mode.nvim',
      ft = 'markdown',
      -- event = "VeryLazy",
      config = function()
        require('markdown-table-mode').setup()
      end,
    },

    -- Obsidian メモ
    {
      'epwalsh/obsidian.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
      event = 'VeryLazy',
      opts = {
        ui = {
          enable = false,
        },
        workspaces = {
          {
            name = 'Memo',
            path = '~/Google Drive/My Drive/Memo',
          },
        },
        note_id_func = function(title)
          return title
        end,
      },
    },

    -- Google 翻訳
    {
      'potamides/pantran.nvim',
      event = 'VeryLazy',
      config = function()
        local pantran = require 'pantran'
        pantran.setup {
          default_engine = 'google',
          engines = {
            google = {
              fallback = {
                default_source = 'auto',
                default_target = 'ja',
              },
            },
          },
        }
        local opts = { noremap = true, silent = true, expr = true }
        vim.keymap.set('n', '<Leader>j', function()
          return pantran.motion_translate() .. '_'
        end, opts)
        vim.keymap.set('x', '<Leader>j', pantran.motion_translate, opts)
      end,
    },

    -- URL 開く
    {
      'sontungexpt/url-open',
      event = 'VeryLazy',
      cmd = 'URLOpenUnderCursor',
      keys = {
        {
          '<Leader>/',
          '<cmd>URLOpenUnderCursor<CR>',
        },
      },
      config = function()
        local status_ok, url_open = pcall(require, 'url-open')
        if not status_ok then
          return
        end
        url_open.setup {
          extra_patterns = {
            -- go.mod go.sum
            {
              pattern = '([^%s]+)',
              prefix = 'https://',
              suffix = '',
              file_patterns = { 'go.mod', 'go.sum' },
              excluded_file_patterns = nil,
              extra_condition = nil,
            },

            -- pubspec.yaml
            {
              pattern = '([^%s]+):',
              prefix = 'https://pub.dev/packages/',
              suffix = '/changelog',
              file_patterns = { 'pubspec.yaml' },
              excluded_file_patterns = nil,
              extra_condition = nil,
            },
          },
        }
      end,
    },

    -- ブラウザ検索
    {
      'voldikss/vim-browser-search',
      event = 'VeryLazy',
      keys = {
        {
          mode = { 'n' },
          '<Leader>?',
          '<cmd>BrowserSearch<CR>',
        },
        {
          mode = { 'x' },
          '<Leader>?',
          ":'<,'>BrowserSearch<CR>",
        },
      },
      config = function()
        vim.g.browser_search_builtin_engines = {
          github = 'https://github.com/search?q=%s',
          google = 'https://google.com/search?q=%s',
          stackoverflow = 'https://stackoverflow.com/search?q=%s',
        }
        vim.g.browser_search_default = 'google'
      end,
    },

    -----------------------------------------------------------------------
    -- LSP
    -----------------------------------------------------------------------

    -- LSP Management
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        'hrsh7th/cmp-nvim-lsp',
        'b0o/schemastore.nvim',
      },
      event = 'VeryLazy',
      config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local on_attach = function(_, bufnr)
          vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
          vim.lsp.inlay_hint.enable(true)
        end

        vim.diagnostic.config {
          -- virtual_text は非表示
          -- virtual_text = {
          --   severity = vim.diagnostic.severity.ERROR,
          -- },
          virtual_text = false,
          -- signcolumn のアイコンを変える
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = ' ',
              [vim.diagnostic.severity.WARN] = ' ',
              [vim.diagnostic.severity.HINT] = ' ',
              [vim.diagnostic.severity.INFO] = ' ',
            },
          },
        }

        local lspconfig = require 'lspconfig'
        require('mason').setup()
        require('mason-lspconfig').setup()
        require('mason-tool-installer').setup {
          ensure_installed = {
            -- LSP
            'gopls',
            'lua-language-server', -- lua_ls
            'typescript-language-server',
            'graphql-language-service-cli',
            'jdtls',
            'yaml-language-server',
            'json-lsp',

            -- Formatter/Linter
            'typos',
            'prettier',
            'prettierd',
            'eslint_d',
            'actionlint',
            'goimports',
            'golangci-lint',
            'ktlint',
            'shellcheck',
            'shfmt',
            'swiftlint',
            'markdownlint',
            'markdownlint-cli2',
            'yamlfmt',
            'yamllint',
            'jsonlint',
            'xmlformatter',
            'selene',
            'stylua',
            'stylelint',
            'tflint',
            'google-java-format',
          },
          auto_update = true,
          run_on_start = true,
          start_delay = 3000,
          debounce_hours = 5,
        }

        -- require('mason-lspconfig').setup_handlers {
        --   function(server_name)
        --     lspconfig[server_name].setup {
        --       on_attach = on_attach,
        --       capabilities = capabilities,
        --     }
        --   end,
        -- }

        -- jsonls
        lspconfig.jsonls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        }

        -- yamlls
        lspconfig.yamlls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            yaml = {
              completion = true,
              validate = true,
              schemas = require('schemastore').yaml.schemas {
                extra = {
                  {
                    url = 'https://raw.githubusercontent.com/blaugold/melos-code/main/melos.yaml.schema.json',
                    name = 'Melos',
                    fileMatch = 'melos.yaml',
                  },
                },
              },
            },
          },
        }

        -- tsserver
        local inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        }
        lspconfig.tsserver.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            typescript = {
              inlayHints = inlayHints,
            },
            javascript = {
              inlayHints = inlayHints,
            },
          },
        }

        -- lua_ls
        lspconfig.lua_ls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            runtime = {
              version = 'LuaJIT',
            },
            Lua = {
              diagnostics = {
                globals = { 'vim' },
              },
              -- inlay hints
              hint = { enable = true },
            },
          },
        }

        -- graphql
        lspconfig.graphql.setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }

        -- gopls
        lspconfig.gopls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            gopls = {
              hints = {
                rangeVariableTypes = true,
                parameterNames = true,
                constantValues = true,
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                functionTypeParameters = true,
              },
            },
          },
        }

        -- kotlin
        local root_files = {
          'settings.gradle', -- Gradle (multi-project)
          'settings.gradle.kts', -- Gradle (multi-project)
          'build.xml', -- Ant
          'pom.xml', -- Maven
        }

        local fallback_root_files = {
          'build.gradle', -- Gradle
          'build.gradle.kts', -- Gradle
        }
        local util = require 'lspconfig.util'
        lspconfig.kotlin_language_server.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { 'kotlin-language-server' },
          root_dir = function(fname)
            return util.root_pattern(unpack(root_files))(fname) or util.root_pattern(unpack(fallback_root_files))(fname)
          end,
        }

        -- SourceKit-LSP
        local function execute(cmd)
          local file = assert(io.popen(cmd, 'r'))
          local output = file:read '*a'
          file:close()
          return output
        end
        lspconfig.sourcekit.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = {
            'sourcekit-lsp',
            '-Xswiftc',
            '-sdk',
            '-Xswiftc',
            execute('xcrun --sdk iphonesimulator --show-sdk-path'):gsub('\n', ''), -- "`xcrun --sdk iphonesimulator --show-sdk-path`"
            '-Xswiftc',
            '-target',
            '-Xswiftc',
            'x86_64-apple-ios'
              .. execute('xcrun --sdk iphonesimulator --show-sdk-version'):gsub('\n', '')
              .. '-simulator', -- "x86_64-apple-ios17.5-simulator"
          },
        }
      end,
    },

    -- Flutter
    {
      'akinsho/flutter-tools.nvim',
      tag = 'v1.10.0',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim',
        'hrsh7th/cmp-nvim-lsp',
      },
      ft = { 'dart' },
      -- event = 'BufRead',
      config = function()
        require('flutter-tools').setup {
          flutter_path = nil,
          flutter_lookup_cmd = 'asdf where flutter',
          fvm = false,
          root_patterns = { '.git', 'pubspec.yaml' },
          ui = {
            border = 'rounded',
            notification_style = 'native',
          },
          decorations = {
            statusline = {
              device = false, -- {flutter_tools_decorations.app_version} if use lualine
              app_version = false, -- {flutter_tools_decorations.device} if use lualine
              project_config = false,
            },
          },
          debugger = {
            enabled = true,
            run_via_dap = true,
            exception_breakpoints = {},
            register_configurations = function(paths)
              local dap = require 'dap'
              dap.adapters.dart = {
                type = 'executable',
                command = paths.flutter_bin,
                args = { 'debug_adapter' },
                console = 'internalConsole',
              }
              dap.configurations.dart = {}
              require('dap.ext.vscode').load_launchjs()
            end,
          },
          widget_guides = {
            enabled = true,
          },
          closing_tags = {
            enabled = true,
            highlight = 'Comment',
            prefix = '  ',
          },
          dev_log = {
            enabled = true,
            notify_errors = false,
            open_cmd = 'botright 15split',
          },
          dev_tools = {
            autostart = false,
            auto_open_browser = true,
          },
          outline = {
            open_cmd = 'rightbelow 50vnew',
            auto_open = false,
          },
          lsp = {
            color = {
              enabled = false,
            },
            on_attach = function(client, bufnr)
              -- inlay hints
              client.server_capabilities.inlayHintProvider = true
              vim.lsp.inlay_hint.enable(true)

              local opts = { noremap = true, silent = true, buffer = bufnr }
              vim.keymap.set('n', '<Leader>n', '<cmd>FlutterRename<CR>', opts)
              vim.keymap.set('n', '<Leader>o', '<cmd>FlutterOutlineToggle<CR>', opts)
              vim.keymap.set('n', '<Leader>m', "<cmd>lua require('telescope').extensions.flutter.commands()<CR>", opts)
            end,
            capabilities = require('cmp_nvim_lsp').default_capabilities {},
            settings = {
              showTodos = true,
              completeFunctionCalls = true,
              analysisExcludedFolders = {
                vim.fn.expand '$HOME/.pub-cache',
                vim.fn.expand '$HOME/.asdf/installs/flutter',
                vim.fn.expand '$HOME/.asdf/installs/dart',
              },
              renameFilesWithClasses = 'prompt',
              enableSnippets = false,
              updateImportsOnRename = true,
            },
          },
        }

        -- ログバッファを開いてもフォーカスを移動させない
        local ui = require 'flutter-tools.ui'
        local original_open_win = ui.open_win
        ---@diagnostic disable-next-line: duplicate-set-field
        ui.open_win = function(cmd, bufnr, opts)
          local current_win = vim.api.nvim_get_current_win()
          original_open_win(cmd, bufnr, opts)
          vim.api.nvim_set_current_win(current_win)
        end

        require('telescope').load_extension 'flutter'
      end,
    },

    -- シンボルの使用状況
    {
      'Wansmer/symbol-usage.nvim',
      event = 'LspAttach',
      config = function()
        require('symbol-usage').setup {
          hl = { link = 'Comment' },
          -- available kinds: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#symbolKind
          kinds = {
            vim.lsp.protocol.SymbolKind.Function,
            vim.lsp.protocol.SymbolKind.Method,
            vim.lsp.protocol.SymbolKind.Class,
            vim.lsp.protocol.SymbolKind.Interface,
            vim.lsp.protocol.SymbolKind.Constructor,
          },
          kinds_filter = {},
          vt_position = 'above',
          vt_priority = nil,
          references = { enabled = true, include_declaration = false },
          definition = { enabled = false },
          implementation = { enabled = false },
          disable = {
            lsp = {},
            filetypes = {
              'alpha',
              'dropbar_menu',
              'NvimTree',
              'DiffviewFileHistory',
              'DiffviewFiles',
              'lazy',
              'mason',
            },
            cond = {},
          },
          symbol_request_pos = 'end',
        }
      end,
    },

    -- Inlay hints
    {
      'chrisgrieser/nvim-lsp-endhints',
      -- ft = {
      --   'typescript',
      --   'typescriptreact',
      --   'javascript',
      --   'javascriptreact',
      --   'lua',
      --   'go',
      --   'dart',
      -- },
      event = 'LspAttach',
      config = function()
        require('lsp-endhints').setup {
          icons = {
            type = '󰜁 ',
            parameter = '󰏪 ',
            offspec = ' ', -- hint kind not defined in official LSP spec
            unknown = ' ', -- hint kind is nil
          },
          label = {
            padding = 1,
            marginLeft = 0,
            bracketedParameters = true,
          },
          autoEnableHints = true,
        }
      end,
    },

    -- package.json のヘルパー
    {
      'vuki656/package-info.nvim',
      dependencies = {
        'MunifTanjim/nui.nvim',
      },
      -- ft = { "json" },
      event = 'BufEnter package.json',
      config = function()
        require('package-info').setup {
          icons = {
            enable = true,
            style = {
              up_to_date = '|  ',
              outdated = '|  ',
            },
          },
          autostart = true,
          hide_up_to_date = true,
          hide_unstable_versions = false,
          package_manager = 'npm',
        }
        vim.keymap.set('n', '<Leader>p', require('package-info').change_version, keymap_opts)
      end,
    },

    -- pubspec.yaml のヘルパー
    {
      'akinsho/pubspec-assist.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
      cmd = {
        'PubspecAssistAddPackage',
        'PubspecAssistAddDevPackage',
        'PubspecAssistPickVersion',
      },
      -- ft = { "yaml" },
      event = 'BufEnter pubspec.yaml',
      config = function()
        require('pubspec-assist').setup {}
        vim.keymap.set('n', '<Leader>p', '<cmd>PubspecAssistPickVersion<CR>', keymap_opts)
      end,
    },

    -- LSP のガベージコレクション
    {
      'zeioth/garbage-day.nvim',
      dependencies = 'neovim/nvim-lspconfig',
      event = 'VeryLazy',
      opts = {
        excluded_lsp_clients = { 'copilot', 'dartls' },
        aggressive_mode = false,
        grace_period = 60 * 30, -- 30 minutes
        wakeup_delay = 5000,
        notifications = true,
      },
    },

    -- LSP cmp
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'rcarriga/cmp-dap',
        { 'tzachar/cmp-tabnine', build = './install.sh' },

        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lsp-document-symbol',

        'onsails/lspkind-nvim',
      },
      event = { 'InsertEnter', 'LspAttach' },
      config = function()
        local cmp = require 'cmp'
        local types = require 'cmp.types'
        local lspkind = require 'lspkind'

        lspkind.init {
          mode = 'symbol_text',
          symbol_map = {
            Copilot = '',
            TabNine = '󰚩',
            Text = '󰉿',
            Method = '󰆧',
            Function = '󰊕',
            Constructor = '',
            Field = '󰜢',
            Variable = '󰀫',
            Class = '󰠱',
            Interface = '',
            Module = '',
            Property = '󰜢',
            Unit = '󰑭',
            Value = '󰎠',
            Enum = '',
            Keyword = '󰌋',
            Snippet = '',
            Color = '󰏘',
            File = '󰈙',
            Reference = '󰈇',
            Folder = '󰉋',
            EnumMember = '',
            Constant = '󰏿',
            Struct = '󰙅',
            Event = '',
            Operator = '󰆕',
            TypeParameter = '',
          },
        }

        vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
        vim.opt.completefunc = 'v:lua.require("cmp").complete()'

        cmp.setup {
          completion = {
            autocomplete = {
              types.cmp.TriggerEvent.InsertEnter,
              types.cmp.TriggerEvent.TextChanged,
            },
            completeopt = 'longest,menu,menuone,noselect,noinsert,preview',
            keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
            keyword_length = 1,
          },
          window = {
            completion = cmp.config.window.bordered {
              border = 'rounded',
              -- max_width = 80,
              winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
            },
            documentation = cmp.config.window.bordered {
              border = 'rounded',
            },
          },
          formatting = {
            expandable_indicator = true,
            fields = { 'kind', 'abbr', 'menu' },
            format = function(entry, vim_item)
              local kind = lspkind.cmp_format {
                ellipsis_char = '…',
                maxwidth = 50,
                mode = 'symbol_text',
                with_text = true,
              }(entry, vim_item)
              local strings = vim.split(kind.kind, '%s', { trimempty = true })
              kind.kind = ' ' .. (strings[1] or '') .. ' '
              kind.menu = '    (' .. (strings[2] or '') .. ')'

              return kind
            end,
          },
          mapping = cmp.mapping.preset.insert {
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm { select = false },
          },
          sources = cmp.config.sources({
            { name = 'copilot', group_index = 2 },
            { name = 'cmp_tabnine', group_index = 2 },
            { name = 'nvim_lsp_document_symbol', group_index = 2 },
            { name = 'nvim_lsp', group_index = 2 },
            { name = 'lazydev', group_index = 2 },
            { name = 'nvim_lsp_signature_help', group_index = 2 },
            { name = 'path', group_index = 2 },
          }, {
            { name = 'buffer', group_index = 2 },
          }),
          performance = {
            max_view_entries = 30,
          },
          experimental = {
            native_menu = false,
            ghost_text = true,
          },
        }

        cmp.setup.filetype({ 'dap-repl', 'dapui_watches' }, {
          enabled = true,
          sources = require('cmp').config.sources {
            { name = 'dap' },
          },
        })

        cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'nvim_lsp_document_symbol' },
          }, {
            { name = 'buffer' },
          }),
        })

        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' },
          }, {
            { name = 'cmdline' },
          }),
          matching = { disallow_symbol_nonprefix_matching = false },
        })
      end,
    },

    -- LSP Copilot
    {
      'zbirenbaum/copilot-cmp',
      dependencies = {
        'zbirenbaum/copilot.lua',
      },
      event = { 'InsertEnter', 'LspAttach' },
      fix_pairs = true,
      cmd = 'Copilot',
      config = function()
        require('copilot').setup {
          panel = {
            enabled = false,
          },
          suggestion = {
            enabled = false,
          },
          filetypes = {
            yaml = true,
            markdown = false,
            help = false,
            gitcommit = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            ['.'] = false,
          },
          copilot_node_command = vim.env.HOME .. '/.asdf/shims/node',
          server_opts_overrides = {},
        }
        require('copilot.api').register_status_notification_handler(function(data)
          local ns = vim.api.nvim_create_namespace 'user.copilot'
          vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
          if vim.fn.mode() == 'i' and data.status == 'InProgress' then
            vim.api.nvim_buf_set_extmark(0, ns, vim.fn.line '.' - 1, 0, {
              virt_text = { { '  Thinking...', 'Comment' } },
              virt_text_pos = 'eol',
              hl_mode = 'combine',
            })
          end
        end)
        require('copilot_cmp').setup {
          method = 'getCompletionsCycling',
        }
      end,
    },

    -- デバッグ
    {
      'mfussenegger/nvim-dap',
      dependencies = {
        'nvim-neotest/nvim-nio',
        'theHamsta/nvim-dap-virtual-text',
        'rcarriga/nvim-dap-ui',
        'nvim-telescope/telescope-dap.nvim',
      },
      event = 'LspAttach',
      config = function()
        vim.keymap.set('n', '<Leader>b', "<cmd>lua require('dap').toggle_breakpoint()<CR>", keymap_opts)
        vim.keymap.set('n', '<Leader>B', "<cmd>lua require('dap').clear_breakpoints()<CR>", keymap_opts)
        vim.keymap.set('n', '<Leader>bc', "<cmd>lua require('dap').continue()<CR>", keymap_opts)
        vim.keymap.set('n', '<Leader>bi', "<cmd>lua require('dap').step_into()<CR>", keymap_opts)
        vim.keymap.set('n', '<Leader>bo', "<cmd>lua require('dap').step_out()<CR>", keymap_opts)
        vim.keymap.set('n', '<Leader>bn', "<cmd>lua require('dap').step_over()<CR>", keymap_opts)
        vim.keymap.set('n', '<Leader>bw', "<cmd>lua require('dapui').elements.watches.add()<CR>", keymap_opts)
        vim.keymap.set('n', '<Leader>bu', function()
          vim.cmd "lua require('dapui').toggle()"
          -- DapUI を表示する際に Inlay hints を非表示にする
          vim.cmd 'lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())'
        end, keymap_opts)

        local repl = require 'dap.repl'
        repl.commands = vim.tbl_extend('force', repl.commands, {
          continue = { '.continue', 'continue', '.c', 'c' },
          next_ = { '.next', 'next', '.n', 'n' },
          step_back = { '.back', 'back', '.b', 'b' },
          reverse_continue = { '.reverse-continue', 'reverse-continue', '.rc', 'rc' },
          into = { '.into', 'into', '.i', 'i' },
          into_targets = { '.into-targets', 'into-targets', '.it', 'it' },
          out = { '.out', 'out', '.o', 'o' },
          scopes = { '.scopes', 'scopes', '.s', 's' },
          threads = { '.threads', 'threads', '.t', 't' },
          frames = { '.frames', 'frames', '.f', 'f' },
          exit = { '.exit', 'exit', '.e', 'e', '.q', 'q' },
          up = { '.up', 'up', '.u', 'u' },
          down = { '.down', 'down', '.d', 'd' },
          goto_ = { '.goto', 'goto', '.g', 'g' },
          pause = { '.pause', 'pause', '.p', 'p' },
          clear = { '.clear', 'clear', '.cr', 'cr' },
          capabilities = { '.capabilities', 'capabilities', '.cap', 'cap' },
          help = { '.help', 'help', '.h', 'h' },
          custom_commands = {},
        })

        vim.api.nvim_set_hl(0, 'white', { fg = '#ffffff' })
        vim.api.nvim_set_hl(0, 'green', { fg = '#3fc56b' })
        vim.api.nvim_set_hl(0, 'yellow', { fg = '#f9c859' })
        vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = 'white' })
        vim.fn.sign_define('DapBreakpointCondition', { text = ' ', texthl = 'white' })
        vim.fn.sign_define('DapBreakpointRejected', { text = ' ', texthl = 'white' })
        vim.fn.sign_define('DapStopped', { text = '󰁕 ', texthl = 'green' })
        vim.fn.sign_define('DapLogPoint', { text = ' ', texthl = 'yellow' })

        require('nvim-dap-virtual-text').setup {
          virt_text_pos = 'eol',
        }
        require('dapui').setup {
          icons = { collapsed = '', current_frame = '', expanded = '' },
          floating = { border = 'rounded', mappings = { close = { 'q', '<Esc>' } } },
          controls = {
            element = 'repl',
            enabled = true,
            icons = {
              disconnect = '',
              pause = '',
              play = '',
              run_last = '',
              step_back = '',
              step_into = '',
              step_out = '',
              step_over = '',
              terminate = '',
            },
          },
          layouts = {
            {
              elements = {
                { id = 'watches', size = 0.25 },
                { id = 'scopes', size = 0.25 },
                { id = 'breakpoints', size = 0.25 },
                { id = 'stacks', size = 0.25 },
              },
              size = 15, -- columns
              position = 'bottom',
            },
            {
              elements = {
                'repl',
              },
              size = 50, -- columns
              position = 'right',
            },
          },
        }

        require('telescope').load_extension 'dap'
      end,
    },

    -- LSP Hover
    {
      'lewis6991/hover.nvim',
      event = 'VeryLazy',
      config = function()
        require('hover').setup {
          init = function()
            require 'hover.providers.lsp'
            require 'hover.providers.dap'
            -- require('hover.providers.gh')
            -- require 'hover.providers.gh_user'
            -- require 'hover.providers.diagnostic'
            -- require 'hover.providers.dictionary'
            -- require 'hover.providers.fold_preview'
            -- require 'hover.providers.man'
            -- require 'hover.providers.jira'
          end,
          preview_opts = {
            border = 'rounded',
          },
          preview_window = false,
          title = true,
          mouse_providers = {
            'LSP',
          },
          mouse_delay = 1000,
        }
        vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
        vim.keymap.set('n', '<Leader>k', require('hover').hover, { desc = 'hover.nvim' })

        -- Mouse support
        vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = 'hover.nvim (mouse)' })
      end,
    },

    -- LSP ポップアップ
    {
      'rmagatti/goto-preview',
      event = 'VeryLazy',
      config = function()
        require('goto-preview').setup {
          width = 160,
          height = 40,
          border = { '↖', '─', '┐', '│', '┘', '─', '└', '│' },
          default_mappings = false,
          debug = false,
          opacity = 30,
          resizing_mappings = false,
          references = {}, -- use telescope built-in
          focus_on_open = true,
          dismiss_on_move = false,
          force_close = true,
          bufhidden = 'wipe',
          stack_floating_preview_windows = true,
          preview_window_title = { enable = true, position = 'left' },
          zindex = 1,
        }

        -- LSP Popup
        vim.keymap.set('n', '<Leader>d', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", bufopts)
        vim.keymap.set('n', '<Leader>i', "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", bufopts)
        vim.keymap.set('n', '<Leader>t', "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", bufopts)
      end,
    },

    -- init.lua の開発サポート
    {
      'folke/lazydev.nvim',
      -- ft = { "lua" },
      event = 'BufRead init.lua',
      opts = {
        library = {
          { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        },
      },
    },
  },
}
