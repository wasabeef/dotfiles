---@diagnostic disable: undefined-global

-- ---------------------------------------------------------
-- 基本設定
-- ---------------------------------------------------------
-- 再読み込み
vim.api.nvim_create_user_command("ReloadVimrc", "source $MYVIMRC", {})
-- Highlight
vim.cmd("syntax on")
-- <Leader>を`<Space>`に設定
vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", " ", "<Leader>", {})
-- <LocalLeader>を`,`に設定
vim.g.maplocalleader = ","
vim.api.nvim_set_keymap("n", ",", "<LocalLeader>", {})

-- 保存されていないファイルがあるときは終了前に保存確認
vim.o.confirm = true
-- バックアップファイル出力無効
vim.o.backup = false
-- swpファイル出力無効
vim.o.swapfile = false
-- 外部でファイルに変更がされた場合は読みなおす
vim.o.autoread = true
-- 保存されていないファイルがあるときでも別のファイルを開くことが出来る
vim.o.hidden = true
-- 入力中のコマンドを表示する
vim.o.showcmd = true
-- クリップボード連携
vim.o.clipboard = "unnamedplus"
-- マウスを有効にする
vim.o.mouse = "a"
-- 文字コードの指定
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.fileencodings = "utf-8,iso-2022-jp,cp932,euc-jp"
-- 行番号
vim.o.number = true
-- カーソル行をハイライト
vim.o.cursorline = true
-- カーソルを行末の一つ先まで移動可能にする
vim.o.virtualedit = "onemore"
-- ビープ音を消す
vim.o.visualbell = true
vim.o.errorbells = false
-- 対応する括弧を強調表示
vim.o.showmatch = true
-- 対応する括弧を表示する時間（最小設定）
vim.o.matchtime = 1
-- ステータスを常に表示、複数バッファでも一つ
vim.o.laststatus = 3
-- ファイル名補完
vim.o.wildmode = "list:longest"
-- 空白文字の表示
-- vim.o.list = true
-- vim.o.listchars = 'tab:→ ,eol:↵,trail:·,extends:↷,precedes:↶'
-- タブ文字をスペースにする
vim.o.expandtab = true
vim.o.tabstop = 2
-- 自動インデント（前の行から引き継ぎ）
vim.o.autoindent = true
-- インデントのネスト上げ下げ
vim.o.smartindent = true
-- 自動インデントでずれる幅
vim.o.shiftwidth = 2
-- 検索で大文字小文字を無視
vim.o.ignorecase = true
vim.o.smartcase = true
-- インクリメンタルサーチ
vim.o.incsearch = true
-- 最後尾まで検索を終えたら次の検索で先頭に移る
vim.o.wrapscan = true
-- 検索文字列をハイライトする
vim.o.hlsearch = true
-- 置換の時 g オプションをデフォルトで有効にする
vim.o.gdefault = true
-- 変更時にガタつかないようにサイン列を常に表示しておく
vim.o.signcolumn = "yes"
-- True Color
vim.o.termguicolors = true
-- コマンドラインの高さを非表示
vim.o.cmdheight = 0

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- ---------------------------------------------------------
-- キーマップ
-- ---------------------------------------------------------
-- ESC連打でハイライト解除
vim.api.nvim_set_keymap("n", "<Esc><Esc>", ":nohlsearch<CR><Esc>", { noremap = true, silent = true })

-- 折り返し時に表示行単位での移動できるようにする
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true })
vim.api.nvim_set_keymap("v", "j", "gj", { noremap = true })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true })
vim.api.nvim_set_keymap("v", "k", "gk", { noremap = true })

-- タブの移動
vim.api.nvim_set_keymap("n", "tf", ":tabfirst<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "tl", ":tablast<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "tt", ":tabnext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "T", ":tabprevious<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "tc", ":tabclose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "to", ":tabonly<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "tn", ":tabnew<CR>", { noremap = true })

-- 画面分割
vim.api.nvim_set_keymap("n", "s", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "sj", "<C-w>j", { noremap = true })
vim.api.nvim_set_keymap("n", "sk", "<C-w>k", { noremap = true })
vim.api.nvim_set_keymap("n", "sl", "<C-w>l", { noremap = true })
vim.api.nvim_set_keymap("n", "sh", "<C-w>h", { noremap = true })
vim.api.nvim_set_keymap("n", "sJ", "<C-w>J", { noremap = true })
vim.api.nvim_set_keymap("n", "sK", "<C-w>K", { noremap = true })
vim.api.nvim_set_keymap("n", "sL", "<C-w>L", { noremap = true })
vim.api.nvim_set_keymap("n", "sH", "<C-w>H", { noremap = true })
vim.api.nvim_set_keymap("n", "sn", "gt", { noremap = true })
vim.api.nvim_set_keymap("n", "sp", "gT", { noremap = true })
vim.api.nvim_set_keymap("n", "s=", "<C-w>=", { noremap = true })
vim.api.nvim_set_keymap("n", "sw", "<C-w>w", { noremap = true })
vim.api.nvim_set_keymap("n", "so", "<C-w>_<C-w>|", { noremap = true })
vim.api.nvim_set_keymap("n", "sO", "<C-w>=", { noremap = true })
vim.api.nvim_set_keymap("n", "sN", ":<C-u>bn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "sP", ":<C-u>bp<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "st", ":<C-u>tabnew<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "ss", ":<C-u>sp<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "sv", ":<C-u>vs<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "sq", ":<C-u>q<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "sQ", ":<C-u>bd<CR>", { noremap = true })

-- ノーマルモードではセミコロンをコロンに
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
-- ノーマルモードでは 0 で行頭、9 で行末
vim.api.nvim_set_keymap("n", "0", "^", { noremap = true })
vim.api.nvim_set_keymap("n", "9", "$", { noremap = true })

-- 保存・終了時のタイポ修正
vim.api.nvim_set_keymap("c", "Q", "q", { noremap = true })
vim.api.nvim_set_keymap("c", "Q!", "q!", { noremap = true })
vim.api.nvim_set_keymap("c", "W", "w", { noremap = true })
vim.api.nvim_set_keymap("c", "W!", "w!", { noremap = true })
vim.api.nvim_set_keymap("c", "WQ!", "wq!", { noremap = true })

-- Ctrl+s で保存
vim.api.nvim_set_keymap("n", "<C-s>", ":update<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<s>", ":update<CR>", { noremap = true, silent = true })

-- Ctrl+q で :q
vim.api.nvim_set_keymap("n", "<C-q>", ":q<CR>", { noremap = true, silent = true })

-- w!!でsudoを忘れても保存
vim.api.nvim_set_keymap("c", "w!!", "w !sudo tee > /dev/null %<CR> :e!<CR>", { noremap = true })

-- 入力モード中のカーソル移動
vim.api.nvim_set_keymap("i", "<C-h>", "<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-j>", "<Down>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-k>", "<Up>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-l>", "<Right>", { noremap = true })

-- 対象の行を移動
vim.api.nvim_set_keymap("n", "<C-Up>", '"zdd<Up>"zP', { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Down>", '"zdd"zp', { noremap = true })
-- 対象の複数行を移動
vim.api.nvim_set_keymap("v", "<C-Up>", '"zx<Up>"zP`[V`]', { noremap = true })
vim.api.nvim_set_keymap("v", "<C-Down>", '"zx"zp`[V`]', { noremap = true })
-- Ctrl + p で繰り返しヤンクした文字をペースト
-- vim.api.nvim_set_keymap("v", "<C-p>", '"0p', { silent = true })
-- Ctrl + m を無効
-- vim.api.nvim_set_keymap("n", "<C-m>", "<Nop>", { noremap = true, silent = true })

-- コマンドラインウィンドウ (:~)
-- 入力途中での上下キーでヒストリー出すのを Ctrl+n/p にも割り当て
vim.api.nvim_set_keymap("c", "<C-n>", 'wildmenumode() ? "\\<c-n>" : "\\<down>"', { expr = true })
vim.api.nvim_set_keymap("c", "<C-p>", 'wildmenumode() ? "\\<c-p>" : "\\<up>"', { expr = true })

-- 不要なプラグインを停止する
vim.g.did_install_default_menus = 1
vim.g.did_install_syntax_menu = 1
vim.g.did_indent_on = 1
vim.g.did_load_filetypes = 1
vim.g.did_load_ftplugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.skip_loading_mswin = 1

-- LSP
vim.keymap.set("n", "<Leader>k", vim.lsp.buf.hover, bufopts)
-- vim.keymap.set('n', '<Leader>f', vim.lsp.buf.formatting, bufopts) -- use ale
vim.keymap.set("n", "<Leader>r", vim.lsp.buf.references, bufopts)
vim.keymap.set("n", "<Leader>dd", vim.lsp.buf.definition, bufopts)
vim.keymap.set("n", "<Leader>D", vim.lsp.buf.declaration, bufopts)
vim.keymap.set("n", "<Leader>ii", vim.lsp.buf.implementation, bufopts)
vim.keymap.set("n", "<Leader>tt", vim.lsp.buf.type_definition, bufopts)
vim.keymap.set("n", "<Leader>n", vim.lsp.buf.rename, bufopts)
-- vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action, bufopts) -- use action-preview
-- vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, bufopts) -- use trouble
vim.keymap.set("n", "<Leader>]", vim.diagnostic.goto_next, bufopts)
vim.keymap.set("n", "<Leader>[", vim.diagnostic.goto_prev, bufopts)

-- 前回開いたファイルのカーソル位置を復旧する
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("restore_cursor", { clear = true }),
  pattern = "*",
  callback = function()
    local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, { row, col })
    end
  end,
})

-- ---------------------------------------------------------
-- Lazy.nvim セットアップ
-- ---------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  checker = { enabled = false },
  spec = {
    -- テーマ
    {
      "rebelot/kanagawa.nvim",
      event = "VimEnter",
      config = function()
        require("kanagawa").setup({
          compile = true, -- 変更したら :KanagawaCompile が必要
          undercurl = false,
          commentStyle = { italic = false },
          functionStyle = { italic = false },
          keywordStyle = { italic = false },
          statementStyle = { italic = false },
          typeStyle = { italic = false },
          transparent = false,
          dimInactive = false,
          terminalColors = true,
          theme = "wave",
          background = {
            dark = "wave",
            light = "wave",
          },
        })
        vim.cmd("colorscheme kanagawa")
      end,
    },

    -- アイコン
    {
      "DaikyXendo/nvim-material-icon",
      event = "VimEnter",
    },

    -- スタート画面
    {
      "goolord/alpha-nvim",
      event = "VimEnter",
      config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
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
          dashboard.button("f", "   Find file", ":Telescope find_files<CR>"),
          dashboard.button("g", "󰱼   Find word", ":Telescope live_grep<CR>"),
          dashboard.button("r", "󰈚   Recent", ":Telescope oldfiles<CR>"),
          dashboard.button("i", "   Edit init.lua", ":e $MYVIMRC <CR>"),
          dashboard.button("z", "   Edit .zshrc", ":e ~/.zshrc <CR>"),
          dashboard.button("w", "   Edit .wezterm.lua", ":e ~/.wezterm.lua <CR>"),
          dashboard.button("t", "   Edit typos.toml", ":e ~/.config/nvim/typos.toml <CR>"),
          dashboard.button("d", "   Edit dprint.json", ":e ~/.config/nvim/dprint.json <CR>"),
          dashboard.button("m", "󱌣   Mason", ":Mason<CR>"),
          dashboard.button("l", "󰒲   Lazy", ":Lazy<CR>"),
          dashboard.button("u", "󰂖   Update plugins", "<cmd>lua require('lazy').sync()<CR>"),
          dashboard.button("q", "   Quit NVIM", ":qa<CR>"),
        }

        alpha.setup(dashboard.opts)

        vim.api.nvim_create_autocmd("User", {
          callback = function()
            local stats = require("lazy").stats()
            local ms = math.floor(stats.startuptime * 100) / 100
            dashboard.section.footer.val = "⚡ Lazy "
              .. stats.loaded
              .. "/"
              .. stats.count
              .. " plugins loaded in "
              .. ms
              .. "ms"
            pcall(vim.cmd.AlphaRedraw)
          end,
        })
      end,
    },

    -- スクリーンセーバー
    {
      "folke/drop.nvim",
      event = "VeryLazy",
      opts = {
        theme = "auto",
        max = 50,
        screensaver = 1000 * 60 * 30, -- 30 minutes
      },
    },

    -- ステータスバー
    {
      "nvim-lualine/lualine.nvim",
      dependencies = {
        "linrongbin16/lsp-progress.nvim",
        "AndreM222/copilot-lualine",
      },
      event = "VimEnter",
      config = function()
        require("lsp-progress").setup()
        local lualine = require("lualine")
        local theme_colors = {
          blue = "#193b73",
          cyan = "#79dac8",
          black = "#0a0a06",
          white = "#c6c6c6",
          red = "#ff5189",
          violet = "#d183e8",
          grey = "#303030",
          caloriemate = "#fbc114",
        }

        local bubbles_theme = {
          normal = {
            a = { fg = theme_colors.white, bg = theme_colors.grey },
            b = { fg = theme_colors.white, bg = theme_colors.blue, gui = "bold" },
            c = { fg = theme_colors.white },
            x = { fg = theme_colors.white },
            y = { fg = theme_colors.black, bg = theme_colors.caloriemate },
            z = { fg = theme_colors.white, bg = theme_colors.grey, gui = "bold" },
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
              statusline = { "alpha" },
            },
            theme = bubbles_theme,
            component_separators = "",
            section_separators = { right = "", left = "" },
          },
          sections = {
            lualine_a = {
              {
                function()
                  return "󰩃"
                end,
                separator = { left = "" },
                padding = { left = 1, right = 3 },
                color = function()
                  local evil_colors = {
                    bg = "#1c1f24",
                    fg = "#abb2bf",
                    yellow = "#d19a66",
                    cyan = "#2aa198",
                    darkblue = "#1c1f24",
                    green = "#98c379",
                    orange = "#e06c75",
                    violet = "#a9a1e1",
                    magenta = "#c678dd",
                    blue = "#61afef",
                    red = "#e06c75",
                  }

                  -- auto change color according to neovims mode
                  local mode_color = {
                    n = evil_colors.blue,
                    i = evil_colors.green,
                    v = evil_colors.red,
                    [""] = evil_colors.red,
                    V = evil_colors.red,
                    c = evil_colors.magenta,
                    no = evil_colors.blue,
                    s = evil_colors.orange,
                    S = evil_colors.orange,
                    [""] = evil_colors.orange,
                    ic = evil_colors.yellow,
                    R = evil_colors.violet,
                    Rv = evil_colors.violet,
                    cv = evil_colors.blue,
                    ce = evil_colors.blue,
                    r = evil_colors.cyan,
                    rm = evil_colors.cyan,
                    ["r?"] = evil_colors.cyan,
                    ["!"] = evil_colors.blue,
                    t = evil_colors.blue,
                  }
                  return { fg = mode_color[vim.fn.mode()] }
                end,
              },
            },
            lualine_b = {
              {
                "branch",
                icon = " ",
                padding = { left = 1, right = 1 },
              },
              {
                "filename",
                path = 1, -- 1: Relative path
                file_status = false,
                separator = { right = "" },
              },
            },
            lualine_c = {
              "'%='",
              {
                "diff",
                symbols = { added = "  ", modified = "  ", removed = "  " },
                separator = " ",
              },
              {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = { error = "  ", warn = "  ", info = "  ", hint = "  " },
              },
            },
            lualine_x = {
              function()
                return require("lsp-progress").progress({
                  format = function(messages)
                    local active_clients = vim.lsp.get_active_clients()
                    local client_count = #active_clients
                    if #messages > 0 then
                      return " LSP:" .. client_count .. " " .. table.concat(messages, " ")
                    end
                    if #active_clients <= 0 then
                      return " LSP:" .. client_count
                    else
                      local client_names = {}
                      for _, client in ipairs(active_clients) do
                        if client and client.name ~= "" then
                          table.insert(client_names, "[" .. client.name .. "]")
                        end
                      end
                      return " LSP:" .. client_count .. " " .. table.concat(client_names, " ")
                    end
                  end,
                })
              end,
            },
            lualine_y = {
              {
                "copilot",
                symbols = {
                  -- spinners = require("copilot-lualine.spinners").moon
                  -- https://github.com/AndreM222/copilot-lualine/blob/main/lua/copilot-lualine/spinners.lua
                  spinners = {
                    " ",
                    " ",
                    " ",
                    " ",
                    " ",
                    " ",
                    " ",
                    " ",
                    " ",
                    " ",
                    " ",
                    " ",
                    " ",
                    " ",
                  },
                },
                separator = { left = "" },
                padding = { left = 1, right = 2 },
              },
            },
            lualine_z = {
              {
                "filetype",
                icon_only = true,
                padding = { left = 2, right = 1 },
              },
              {
                "filetype",
                icons_enabled = false,
                separator = { right = "" },
                padding = { left = 0, right = 1.5 },
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
      "simeji/winresizer",
      event = "VeryLazy",
    },

    -- スムーススクロール
    {
      "karb94/neoscroll.nvim",
      event = "VeryLazy",
      config = function()
        local neoscroll = require("neoscroll")
        neoscroll.setup({
          mappings = {
            "<C-u>",
            "<C-d>",
            "<C-b>",
            "<C-f>",
            -- "<C-y>",
            -- "<C-e>", -- use simeji/winresizer
            -- "zt",
            -- "zz",
            -- "zb",
          },
          hide_cursor = false,
          performance_mode = true,
        })
        local keymap = {
          ["<C-u>"] = function()
            neoscroll.ctrl_u({ duration = 50 })
          end,
          ["<C-d>"] = function()
            neoscroll.ctrl_d({ duration = 50 })
          end,
          ["<C-b>"] = function()
            neoscroll.ctrl_b({ duration = 120 })
          end,
          ["<C-f>"] = function()
            neoscroll.ctrl_f({ duration = 120 })
          end,
        }

        local modes = { "n", "v", "x" }
        for key, func in pairs(keymap) do
          vim.keymap.set(modes, key, func)
        end
      end,
    },

    -- スクロールバー
    {
      "petertriho/nvim-scrollbar",
      event = "VeryLazy",
      config = function()
        require("scrollbar").setup({
          handle = { color = "#006df2" },
          excluded_filetypes = {
            "dropbar_menu",
          },
        })
      end,
    },

    -- winbar
    {
      "Bekaboo/dropbar.nvim",
      dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
      },
      event = "VeryLazy",
      config = function()
        require("dropbar").setup({
          background = false,
        })
      end,
    },

    -- LineLength 80 に色を付ける
    -- vim.o.colorcolumn = "80"
    {
      "m4xshen/smartcolumn.nvim",
      event = "VeryLazy",
      opts = {
        disabled_filetypes = { "alpha" },
      },
    },

    -- コメントアウト
    {
      "numToStr/Comment.nvim",
      event = "VeryLazy",
    },

    -- 括弧
    {
      "tpope/vim-surround",
      event = "VeryLazy",
    },

    -- ペア
    {
      "windwp/nvim-autopairs",
      event = "VeryLazy",
      config = true,
    },

    -- EditorConfig
    {
      "editorconfig/editorconfig-vim",
      event = "VeryLazy",
    },

    -- Incremental Search
    {
      "kevinhwang91/nvim-hlslens",
      event = "VeryLazy",
      config = function()
        require("hlslens").setup()
      end,
    },

    -- 置換
    {
      "MagicDuck/grug-far.nvim",
      event = "VeryLazy",
      keys = {
        {
          "<C-/>",
          "<cmd>GrugFar<CR>",
          mode = { "n" },
        },
      },
      config = function()
        require("grug-far").setup({
          windowCreationCommand = "rightbelow 120vnew",
        })
      end,
    },

    -- カーソルジャンプ
    {
      "phaazon/hop.nvim",
      branch = "v2",
      event = "VeryLazy",
      config = function()
        require("hop").setup({ keys = "etovxqpdygfblzhckisuran", term_seq_bias = 0.5 })
        vim.api.nvim_set_keymap("n", "ff", ":HopPattern<CR>", { noremap = true })
        vim.api.nvim_set_keymap("n", "fw", ":HopWord<CR>", { noremap = true })
        vim.api.nvim_set_keymap("n", "fl", ":HopLine<CR>", { noremap = true })
        vim.api.nvim_set_hl(0, "HopNextKey", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "HopNextKey1", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "HopNextKey2", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "HopUnmatched", { fg = "#4B5263" })
      end,
    },

    -- カーソル位置ハイライト
    {
      "RRethy/vim-illuminate",
      event = "VeryLazy",
      config = function()
        require("illuminate").configure({
          providers = {
            "lsp",
            "treesitter",
            "regex",
          },
          delay = 100,
          filetype_overrides = {},
          filetypes_denylist = {
            "dropbar_menu",
            "NvimTree",
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
        })
      end,
    },

    -- コピーハイライト
    {
      "machakann/vim-highlightedyank",
      event = "VeryLazy",
    },

    -- クリップボード履歴
    {
      "ptdewey/yankbank-nvim",
      event = "VeryLazy",
      config = function()
        require("yankbank").setup()
        vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>YankBank<CR>", { noremap = true, silent = true })
      end,
    },

    -- 引数の入れ替え g> g< gs gsl gsh gsk gsj
    {
      "machakann/vim-swap",
      event = "VeryLazy",
    },

    -- テキストの分割と結合
    {
      "echasnovski/mini.splitjoin",
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("mini.splitjoin").setup({
          mappings = {
            toggle = "gss",
            split = "",
            join = "",
          },
        })
      end,
    },

    -- インデント表示、Textobjects
    {
      "echasnovski/mini.indentscope",
      event = { "BufRead", "BufNewFile" },
      init = function()
        vim.api.nvim_create_autocmd("FileType", {
          pattern = {
            "help",
            "alpha",
            "Trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
          },
          callback = function()
            vim.b.miniindentscope_disable = true
          end,
        })
      end,
      config = function()
        require("mini.indentscope").setup({
          options = {
            try_as_border = true,
            indent_at_cursor = true,
          },
          draw = {
            delay = 300,
            -- animation = require("mini.indentscope").gen_animation.none(),
          },
          mappings = {
            object_scope = "ii",
            object_scope_with_border = "ai",
            goto_top = "[i",
            goto_bottom = "]i",
          },
          -- symbol = "󰍳",
        })
      end,
    },

    -- カラーハイライト
    {
      "NvChad/nvim-colorizer.lua",
      event = "VeryLazy",
      opts = {
        filetypes = { "*" },
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
          mode = "virtualtext", -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = false, -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
          virtualtext = "",
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
      "fei6409/log-highlight.nvim",
      event = "VeryLazy",
      ft = "log",
      config = true,
    },

    -- ファイルツリー
    {
      "nvim-tree/nvim-tree.lua",
      event = "VeryLazy",
      config = function()
        local function on_attach(bufnr)
          local api = require("nvim-tree.api")

          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          api.config.mappings.default_on_attach(bufnr)
          vim.keymap.set("n", "x", api.node.run.system, opts("Open System"))
          vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
          vim.keymap.set("n", "=", api.tree.change_root_to_node, opts("CD"))
          vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Dir Up"))
          vim.keymap.set("n", "l", api.node.open.edit, opts("Edit"))
          vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Node"))
          vim.keymap.set("n", "s", "", opts(""))
          vim.keymap.set("n", "sl", "<c-w>l", opts(""))
        end

        vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

        require("nvim-tree").setup({
          on_attach = on_attach,
          view = {
            signcolumn = "yes",
            float = {
              enable = true,
              open_win_config = {
                height = 65,
                width = 45,
              },
            },
          },
          diagnostics = {
            enable = true,
            icons = {
              hint = " ",
              info = " ",
              warning = " ",
              error = " ",
            },
            show_on_dirs = true,
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
      end,
    },

    -- nvim-tree でファイル名変更した場合などに自動で更新
    {
      "antosha417/nvim-lsp-file-operations",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-tree.lua",
      },
      event = "VeryLazy",
      config = function()
        require("lsp-file-operations").setup()
      end,
    },

    -- Git Blame
    {
      "lewis6991/gitsigns.nvim",
      event = "VeryLazy",
      config = function()
        require("gitsigns").setup({
          signs = {
            add = { text = "┃" },
            change = { text = "┃" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
          },
          signs_staged = {
            add = { text = "┃" },
            change = { text = "┃" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
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
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
            virt_text_priority = 100,
          },
          current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
          sign_priority = 6,
          update_debounce = 100,
          status_formatter = nil, -- Use default
          max_file_length = 40000, -- Disable if file is longer than this (in lines)
          preview_config = {
            -- Options passed to nvim_open_win
            border = "single",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
          },
        })
        -- スクロールバーにも表示
        require("scrollbar.handlers.gitsigns").setup()
      end,
    },

    -- コードハイライト
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      event = "VeryLazy",
      init = function(plugin)
        -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
        -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
        -- no longer trigger the **nvim-treeitter** module to be loaded in time.
        -- Luckily, the only thins that those plugins need are the custom queries, which we make available
        -- during startup.
        -- CODE FROM LazyVim (thanks folke!) https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
        require("lazy.core.loader").add_to_rtp(plugin)
        pcall(require, "nvim-treesitter.query_predicates")
      end,
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = {
            "lua",
            "javascript",
            "vim",
            "vimdoc",
            "dart",
            "graphql",
            "bash",
            "swift",
            "kotlin",
            "go",
            "printf",
            "regex",
            "json",
            "json5",
            "javascript",
            "typescript",
            "css",
            "html",
            "markdown",
            "markdown_inline",
            "yaml",
            "toml",
            "xml",
          },
          sync_install = false,
          auto_install = false,
          highlight = {
            enable = true,
            disable = function(_, buf)
              local max_filesize = 100 * 1024 -- 100 KB
              local check_stats = (vim.uv or vim.loop).fs_stat
              local ok, stats = pcall(check_stats, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                return true
              else
                return false
              end
            end,
            additional_vim_regex_highlighting = false,
          },
        })
      end,
    },

    -- fzf ファイル・コマンド検索
    {
      "nvim-telescope/telescope.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-media-files.nvim",
        "dimaportenko/telescope-simulators.nvim",
        "jonarrien/telescope-cmdline.nvim",
      },
      event = "VeryLazy",
      config = function()
        vim.api.nvim_set_keymap(
          "n",
          "<C-o>",
          "<cmd>lua require('telescope.builtin').find_files({hidden = true})<CR>",
          { noremap = true, silent = true }
        )
        vim.api.nvim_set_keymap(
          "n",
          "<C-g>",
          "<cmd>lua require('telescope.builtin').live_grep()<CR>",
          { noremap = true, silent = true }
        )
        -- vim.api.nvim_set_keymap(
        --   "n",
        --   "<C-p>",
        --   "<cmd>lua require('telescope.builtin').oldfiles()<CR>",
        --   { noremap = true, silent = true }
        -- )
        -- vim.api.nvim_set_keymap(
        --   "n",
        --   "<C-x>",
        --   "<cmd>lua require('telescope.builtin').commands()<CR>",
        --   { noremap = true, silent = true }
        -- )
        -- vim.api.nvim_set_keymap(
        --   "n",
        --   "<C-m>",
        --   "<cmd>lua require('telescope.builtin').keymaps()<CR>",
        --   { noremap = true, silent = true }
        -- )
        vim.api.nvim_set_keymap("n", "<C-x>", "<cmd>Telescope simulators run<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", ":", ":Telescope cmdline<CR>", { noremap = true, desc = "Cmdline" })
        vim.api.nvim_set_keymap("n", ";", ":Telescope cmdline<CR>", { noremap = true, desc = "Cmdline" })

        local telescope = require("telescope")
        telescope.setup({
          defaults = {
            initial_mode = "insert",
            prompt_prefix = " ",
            selection_caret = "󰁕 ",
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
              -- "--hidden",
              "--glob",
              "!**/.git/*",
            },
            mappings = {
              n = {
                ["<C-q>"] = "close",
              },
              i = {
                ["<C-q>"] = "close",
                ["<Tab>"] = function(prompt_bufnr)
                  local action_state = require("telescope.actions.state")
                  local actions = require("telescope.actions")
                  local picker = action_state.get_current_picker(prompt_bufnr)
                  local prompt_win = picker.prompt_win
                  local previewer = picker.previewer
                  local bufnr = previewer.state.bufnr or previewer.state.termopen_bufnr
                  local winid = previewer.state.winid or vim.fn.bufwinid(bufnr)
                  vim.keymap.set("n", "<Tab>", function()
                    vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", prompt_win))
                  end, { buffer = bufnr })
                  vim.keymap.set("n", "<esc>", function()
                    actions.close(prompt_bufnr)
                  end, { buffer = bufnr })
                  vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", winid))
                end,
              },
            },
            extensions = {
              fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
              },
              cmdline = {},
            },
            preview = {
              treesitter = false,
              mime_hook = function(filepath, bufnr, opts)
                local is_image = function(_)
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
                    "-w",
                    "100",
                    "-b",
                    filepath,
                  }, {
                    on_stdout = send_output,
                    stdout_buffered = true,
                    pty = true,
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
        })
        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")
        telescope.load_extension("media_files")
        require("simulators").setup({
          android_emulator = true,
          apple_simulator = true,
        })
        telescope.load_extension("cmdline")
      end,
    },

    -- コードアクション、差分修正
    {
      "aznhe21/actions-preview.nvim",
      dependencies = {
        "nvim-telescope/telescope.nvim",
      },
      event = "VeryLazy",
      config = function()
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "<Leader>a", "<cmd>lua require('actions-preview').code_actions()<CR>", bufopts)

        require("actions-preview").setup({
          diff = {
            algorithm = "histogram",
            -- 差分がある部分の前後に表示する行数。git diff --unified=<n>相当
            ctxlen = 3,
            -- 同一ファイルの差分塊間の行数がこれ以下なら全部表示する。git diff --inter-hunk-context=<lines>相当
            interhunkctxlen = 0,
            -- あらゆるスペースの変更を無視する。trueならgit diff --ignore-all-space相当
            ignore_whitespace = false,
            -- 行頭や連続するスペースの変更を無視する。trueならgit diff --ignore-space-change相当
            ignore_whitespace_change = false,
            -- 行末スペースの変更を無視する。trueならgit diff --ignore-space-at-eol相当
            ignore_whitespace_change_at_eol = false,
            -- 改行前のCR（\r）を無視する。trueならgit diff --ignore-cr-at-eol相当
            ignore_cr_at_eol = false,
            -- 連続した空行の変更を無視する。trueならgit diff --ignore-blank-lines相当
            ignore_blank_lines = false,
            -- 差分のズレを抑制する。trueならgit diff --indent-heuristic相当。actions-preview.nvimではデフォルト無効
            indent_heuristic = false,
          },
          backend = { "telescope" },
          telescope = require("telescope.themes").get_dropdown({
            color_devicons = true,
            layout_strategy = "vertical",
            layout_config = {
              width = 0.5,
              height = 0.75,
            },
          }),
        })
      end,
    },

    -- Diagnostics
    {
      "folke/trouble.nvim",
      event = "VeryLazy",
      opts = {
        modes = {
          preview_float = {
            mode = "diagnostics",
            preview = {
              type = "float",
              relative = "editor",
              border = "rounded",
              title = "Trouble",
              title_pos = "center",
              position = { 0, -2 },
              size = { width = 0.3, height = 0.3 },
            },
          },
        },
      },
      keys = {
        {
          "<Leader>e",
          "<cmd>Trouble preview_float toggle filter.buf=0<CR>",
          desc = "Diagnostics (Trouble)",
        },
      },
    },

    -- Lint
    {
      "dense-analysis/ale",
      event = "VeryLazy",
      config = function()
        -- vim.g.ale_echo_msg_error_str = "Err"
        -- vim.g.ale_sign_error = "🔥"
        -- vim.g.ale_echo_msg_warning_str = "Warn"
        -- vim.g.ale_sign_warning = "‼️"
        -- vim.g.ale_echo_msg_info_str = "Info"
        -- vim.g.ale_sign_info = "🤔"
        vim.g.ale_virtualtext_cursor = "disabled"
        vim.g.ale_lint_on_enter = 0
        vim.g.ale_sign_column_always = 0
        vim.g.ale_set_highlights = 0
        vim.g.ale_lint_on_save = 0
        vim.g.ale_linters_explicit = 1
        vim.g.ale_linters = {
          sh = { "shellcheck" },
          lua = { "stylua" },
          markdown = { "textlint" },
          json = { "jq", "jsonlint" },
          yaml = { "yamllint", "actionlint" },
          go = { "gofmt", "gopls" },
          swift = { "swiftlint" },
        }
        vim.g.ale_fixers = {
          ["*"] = { "trim_whitespace" },
          sh = { "shfmt" },
          bash = { "shfmt" },
          zsh = { "shfmt" },
          lua = { "stylua" },
          markdown = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          toml = { "dprint" },
          html = { "prettier" },
          css = { "prettier" },
          less = { "prettier" },
          scss = { "prettier" },
          xml = { "xmllint" },
          vue = { "prettier" },
          svelte = { "prettier" },
          astro = { "prettier" },
          javascript = { "prettier", "eslint" },
          javascriptreact = { "prettier", "eslint", "stylelint" },
          typescript = { "prettier", "tslint", "eslint" },
          typescriptreact = { "prettier", "tslint", "eslint", "stylelint" },
          java = { "eclipselsp" },
          kotlin = { "ktlint" },
          dart = { "dart-format" },
          go = { "gofmt", "goimports" },
          graphql = { "prettier" },
          swift = { "swiftformat" },
        }
        vim.api.nvim_set_keymap("n", "<Leader>f", ":ALEFix<CR>", { noremap = true, silent = true })
      end,
    },

    -- インラインターミナル
    {
      "akinsho/toggleterm.nvim",
      event = "VeryLazy",
      keys = {
        { "<C-t>t", "<Cmd>ToggleTerm direction=float<CR>" },
        { "<C-t>f", "<Cmd>ToggleTerm direction=float<CR>" },
        { "<C-t>v", "<Cmd>ToggleTerm direction=vertical<CR>" },
        { "<C-t>h", "<Cmd>ToggleTerm direction=horizontal<CR>" },
      },
      opts = {
        open_mapping = "<C-t>",
        direction = "float",
        float_opts = {
          winblend = 10,
        },
      },
    },

    -- 通知
    {
      "rcarriga/nvim-notify",
      event = "VeryLazy",
      config = function()
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
      end,
    },

    -- バッファ操作
    {
      "j-morano/buffer_manager.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      event = { "BufReadPre", "BufNewFile" },
      opts = {
        -- order_buffers = "lastused",
        width = 0.4,
        height = 0.3,
      },
      keys = {
        {
          "[]",
          function()
            require("buffer_manager.ui").toggle_quick_menu()
          end,
        },
      },
    },
    {
      "willothy/nvim-cokeline",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      event = { "BufReadPre", "BufNewFile" },
      keys = {
        { "[[", "<Plug>(cokeline-focus-prev)", { silent = true, desc = "Prev Buffer" } },
        { "]]", "<Plug>(cokeline-focus-next)", { silent = true, desc = "Next Buffer" } },
        {
          "\\][",
          ":lua for _, buf in ipairs(vim.api.nvim_list_bufs()) do if buf ~= vim.api.nvim_get_current_buf() then vim.api.nvim_buf_delete(buf, {force = true}) end end<CR>",
          { silent = true, desc = "Close Other Buffers" },
        },
        { "\\\\", "<cmd>bd<CR>", { silent = true, desc = "Close Current Buffer" } },
      },
      config = function()
        local get_hex = require("cokeline.hlgroups").get_hl_attr
        local mappings = require("cokeline/mappings")

        local comments_fg = get_hex("Comment", "fg")
        local errors_fg = get_hex("DiagnosticError", "fg")
        local warnings_fg = get_hex("DiagnosticWarn", "fg")

        local active_fg = get_hex("Normal", "fg")
        -- local active_bg = get_hex("ColorColumn", "bg")
        local active_bg = "#281709"
        local inactive_fg = get_hex("Comment", "fg")
        local inactive_bg = get_hex("Normal", "bg")

        local red = vim.g.terminal_color_1
        -- local green = vim.g.terminal_color_8
        local yellow = vim.g.terminal_color_3

        local components = {
          margin = {
            text = " ",
            bg = get_hex("Normal", "bg"),
            truncation = { priority = 1 },
          },

          space = { text = " ", truncation = { priority = 1 } },

          two_spaces = { text = "  ", truncation = { priority = 1 } },

          separator_left = {
            text = "",
            fg = function(buffer)
              return buffer.is_focused and active_bg or inactive_bg
            end,
            bg = inactive_bg,
          },

          separator_right = {
            text = "",
            fg = function(buffer)
              return buffer.is_focused and active_bg or inactive_bg
            end,
            bg = inactive_bg,
          },

          devicon = {
            text = function(buffer)
              return (mappings.is_picking_focus() or mappings.is_picking_close()) and buffer.pick_letter .. " "
                or buffer.devicon.icon
            end,
            fg = function(buffer)
              return (mappings.is_picking_focus() and yellow)
                or (mappings.is_picking_close() and red)
                or buffer.devicon.color
            end,
            style = function(_)
              return (mappings.is_picking_focus() or mappings.is_picking_close()) and "italic,bold" or nil
            end,
            truncation = { priority = 1 },
          },

          index = {
            text = function(buffer)
              return buffer.index .. ": "
            end,
            truncation = { priority = 1 },
          },

          unique_prefix = {
            text = function(buffer)
              return buffer.unique_prefix
            end,
            fg = comments_fg,
            style = "italic",
            truncation = { priority = 3, direction = "left" },
          },

          filename = {
            text = function(buffer)
              return buffer.filename
            end,
            style = function(buffer)
              return ((buffer.is_focused and buffer.diagnostics.errors ~= 0) and "bold,underline")
                or (buffer.is_focused and "bold")
                or (buffer.diagnostics.errors ~= 0 and "underline")
                or nil
            end,
            truncation = { priority = 2, direction = "left" },
          },

          diagnostics = {
            text = function(buffer)
              return (buffer.diagnostics.errors ~= 0 and "  " .. buffer.diagnostics.errors)
                or (buffer.diagnostics.warnings ~= 0 and "  " .. buffer.diagnostics.warnings)
                or ""
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
              return buffer.is_modified and "󰆓 " or " "
            end,
            fg = function(buffer)
              return buffer.is_modified and warnings_fg or nil
            end,
            delete_buffer_on_left_click = true,
            truncation = { priority = 1 },
          },
        }

        require("cokeline").setup({
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
              return buffer.type ~= "terminal" and buffer.type ~= "quickfix" and buffer.filename ~= "[No Name]"
            end,
            filter_valid = function(buffer)
              return buffer.type ~= "terminal" and buffer.type ~= "quickfix" and buffer.filename ~= "[No Name]"
            end,
          },

          sidebar = {
            filetype = { "NvimTree" },
            components = {
              {
                text = function(buf)
                  return buf.filetype
                end,
                fg = yellow,
                bg = function()
                  return get_hex("NvimTreeNormal", "bg")
                end,
                bold = true,
              },
            },
          },
        })
      end,
    },

    -- タスクショートカット
    {
      "stevearc/overseer.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
      },
      event = "VeryLazy",
      config = function()
        local overseer = require("overseer")

        -- Git
        overseer.register_template({
          name = "tig status",
          builder = function()
            return {
              cmd = "tig",
              args = { "status" },
            }
          end,
        })

        overseer.register_template({
          name = "git pull origin main",
          builder = function()
            return {
              cmd = "git",
              args = { "pull", "origin", "main" },
            }
          end,
        })
        overseer.register_template({
          name = "chezmoi re-add",
          builder = function()
            return {
              cmd = "chezmoi",
              args = { "re-add" },
            }
          end,
        })

        overseer.setup({
          strategy = {
            "toggleterm",
            -- quit_on_exit = "success",
            dap = false,
          },
        })
        vim.api.nvim_set_keymap("n", "<C-.>", "<cmd>OverseerRun<CR>", { noremap = true, silent = true })
      end,
    },

    -- キー入力
    {
      "NStefan002/screenkey.nvim",
      event = "VeryLazy",
      config = function()
        require("screenkey").setup({
          disable = {
            filetypes = {
              "alpha",
            },
          },
          win_opts = {
            title = "Keys",
            width = 40,
            height = 1,
          },
          display_infront = { "Telescope*", "toggleterm" },
          keys = {
            ["<leader>"] = "<Leader>",
          },
        })
        vim.api.nvim_create_autocmd("BufRead", {
          group = vim.api.nvim_create_augroup("AutostartScreenkey", {}),
          command = "Screenkey toggle",
          desc = "Autostart Screenkey on BufRead",
        })
      end,
    },

    -----------------------------------------------------------------------
    -- LSP
    -----------------------------------------------------------------------

    -- LSP Management
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        "hrsh7th/cmp-nvim-lsp",
      },
      event = "VeryLazy",
      config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities({
          textDocument = { completion = { completionItem = { snippetSupport = false } } },
        })

        local on_attach = function(_, bufnr)
          vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        end

        local lspconfig = require("lspconfig")
        require("mason").setup()
        require("mason-lspconfig").setup()
        require("mason-tool-installer").setup({
          ensure_installed = {
            -- LSP
            "typos-lsp",
            "gopls",
            "lua-language-server",
            "typescript-language-server",
            "graphql-language-service-cli",

            -- Formatter
            "prettier",
            "actionlint",
            "goimports",
            "ktlint",
            "shellcheck",
            "shfmt",
            "swiftlint",
            "yamlfmt",
            "yamllint",
          },
          auto_update = true,
          run_on_start = true,
          start_delay = 3000,
          debounce_hours = 5,
        })
        require("mason-lspconfig").setup_handlers({
          function(server_name)
            -- dartls を除く (flutter-tools.nvim で行う)
            if server_name ~= "dartls" then
              lspconfig[server_name].setup({
                on_attach = on_attach,
                capabilities = capabilities,
              })
            end
          end,
        })

        -- typo-lsp
        lspconfig.typos_lsp.setup({
          on_attach = function(client, bufnr)
            local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
            if filetype == "log" or filetype == "toggleterm" then
              client.stop()
            end
          end,
          init_options = {
            config = "$HOME/.config/nvim/typos.toml",
            diagnosticSeverity = "Warning",
          },
        })

        -- SourceKit-LSP
        local function execute(cmd)
          local file = assert(io.popen(cmd, "r"))
          local output = file:read("*a")
          file:close()
          return output
        end
        lspconfig.sourcekit.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = {
            "sourcekit-lsp",
            "-Xswiftc",
            "-sdk",
            "-Xswiftc",
            execute("xcrun --sdk iphonesimulator --show-sdk-path"):gsub("\n", ""), -- "`xcrun --sdk iphonesimulator --show-sdk-path`"
            "-Xswiftc",
            "-target",
            "-Xswiftc",
            "x86_64-apple-ios"
              .. execute("xcrun --sdk iphonesimulator --show-sdk-version"):gsub("\n", "")
              .. "-simulator", -- "x86_64-apple-ios17.5-simulator"
          },
        })
      end,
    },

    -- Flutter
    {
      "akinsho/flutter-tools.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim",
        "hrsh8th/cmp-nvim-lsp",
      },
      ft = { "dart" },
      event = "VeryLazy",
      config = function()
        require("flutter-tools").setup({
          flutter_path = nil,
          flutter_lookup_cmd = "asdf where flutter",
          fvm = false,
          root_patterns = { ".git", "pubspec.yaml" },
          ui = {
            border = "rounded",
            notification_style = "native",
          },
          decorations = {
            statusline = {
              device = false, -- {flutter_tools_decorations.app_version} lualine
              app_version = false, -- {flutter_tools_decorations.device} lualine
              project_config = false,
            },
          },
          debugger = {
            enabled = true,
            run_via_dap = true,
            exception_breakpoints = {},
            register_configurations = function(paths)
              local dap = require("dap")
              dap.adapters.dart = {
                type = "executable",
                command = paths.flutter_bin,
                args = { "debug_adapter" },
              }
              dap.configurations.dart = {}
              require("dap.ext.vscode").load_launchjs()
            end,
          },
          widget_guides = {
            enabled = true,
          },
          closing_tags = {
            enabled = true,
            highlight = "Comment",
            prefix = "  ",
          },
          dev_log = {
            enabled = true,
            notify_errors = false,
            open_cmd = "botright 20split",
          },
          dev_tools = {
            autostart = false,
            auto_open_browser = true,
          },
          outline = {
            open_cmd = "rightbelow 50vnew",
            auto_open = false,
          },
          lsp = {
            color = {
              enabled = false,
            },
            on_attach = function(_, bufnr)
              local bufopts = { noremap = true, silent = true, buffer = bufnr }
              vim.keymap.set(
                "n",
                "<Leader>m",
                "<cmd>lua require('telescope').extensions.flutter.commands()<CR>",
                bufopts
              )
              vim.keymap.set("n", "<Leader>o", "<cmd>FlutterOutlineToggle<CR>", bufopts)
            end,
            capabilities = require("cmp_nvim_lsp").default_capabilities({
              textDocument = { completion = { completionItem = { snippetSupport = false } } },
            }),
            settings = {
              showTodos = true,
              completeFunctionCalls = true,
              analysisExcludedFolders = {
                vim.fn.expand("$HOME/.pub-cache"),
                vim.fn.expand("$HOME/.asdf/installs/flutter"),
                vim.fn.expand("$HOME/.asdf/installs/dart"),
              },
              renameFilesWithClasses = "prompt",
              enableSnippets = false,
              updateImportsOnRename = true,
            },
          },
        })

        require("telescope").load_extension("flutter")
      end,
    },

    -- LSP のガベージコレクション
    {
      "zeioth/garbage-day.nvim",
      dependencies = "neovim/nvim-lspconfig",
      event = "VeryLazy",
      opts = {
        excluded_lsp_clients = { "copilot", "typos_lsp", "dartls" },
        aggressive_mode = false,
        grace_period = 60 * 30, -- 30 minutes
        wakeup_delay = 5000,
        notifications = true,
      },
    },

    -- LSP cmp
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",

        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lsp-document-symbol",

        "onsails/lspkind-nvim",
      },
      event = { "InsertEnter", "LspAttach" },
      config = function()
        vim.diagnostic.config({
          -- virtual_text は非表示
          -- virtual_text = {
          --   severity = vim.diagnostic.severity.ERROR,
          -- },
          virtual_text = false,
          -- signcolumn のアイコンを変える
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN] = " ",
              [vim.diagnostic.severity.HINT] = " ",
              [vim.diagnostic.severity.INFO] = " ",
            },
          },
        })

        local cmp = require("cmp")
        local types = require("cmp.types")
        local lspkind = require("lspkind")

        lspkind.init({
          mode = "symbol_text",
          symbol_map = {
            Copilot = "",
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "󰈇",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "",
          },
        })

        vim.opt.completeopt = { "menu", "menuone", "noselect" }
        vim.o.completefunc = 'v:lua.require("cmp").complete()'

        cmp.setup({
          completion = {
            autocomplete = {
              types.cmp.TriggerEvent.InsertEnter,
              types.cmp.TriggerEvent.TextChanged,
            },
            completeopt = "longest,menu,menuone,noselect,noinsert,preview",
            keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
            keyword_length = 1,
          },
          window = {
            completion = cmp.config.window.bordered({
              border = "rounded",
              -- max_width = 80,
              winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            }),
            documentation = cmp.config.window.bordered({
              border = "rounded",
            }),
          },
          formatting = {
            expandable_indicator = true,
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
              local kind = lspkind.cmp_format({
                ellipsis_char = "…",
                maxwidth = 50,
                mode = "symbol_text",
                with_text = true,
              })(entry, vim_item)
              local strings = vim.split(kind.kind, "%s", { trimempty = true })
              kind.kind = " " .. (strings[1] or "") .. " "
              kind.menu = "    (" .. (strings[2] or "") .. ")"

              return kind
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
          }),
          sources = cmp.config.sources({
            { name = "copilot", group_index = 2 },
            { name = "nvim_lsp", group_index = 2 },
            { name = "vsnip", group_index = 2 },
            { name = "nvim_lsp_signature_help", group_index = 2 },
            { name = "path", group_index = 2 },
          }, {
            { name = "buffer", group_index = 2 },
          }),
          performance = {
            max_view_entries = 30,
          },
          experimental = {
            native_menu = false,
            ghost_text = true,
          },
        })

        cmp.setup.cmdline({ "/", "?" }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "nvim_lsp_document_symbol" },
          }, {
            { name = "buffer" },
          }),
        })

        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "path" },
          }, {
            { name = "cmdline" },
          }),
          matching = { disallow_symbol_nonprefix_matching = false },
        })
      end,
    },

    -- LSP Copilot
    {
      "zbirenbaum/copilot-cmp",
      dependencies = {
        "zbirenbaum/copilot.lua",
      },
      event = { "InsertEnter", "LspAttach" },
      fix_pairs = true,
      cmd = "Copilot",
      config = function()
        require("copilot").setup({
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
            ["."] = false,
          },
          copilot_node_command = vim.env.HOME .. "/.asdf/shims/node",
          server_opts_overrides = {},
        })
        require("copilot.api").register_status_notification_handler(function(data)
          local ns = vim.api.nvim_create_namespace("user.copilot")
          vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
          if vim.fn.mode() == "i" and data.status == "InProgress" then
            vim.api.nvim_buf_set_extmark(0, ns, vim.fn.line(".") - 1, 0, {
              virt_text = { { "  Thinking...", "Comment" } },
              virt_text_pos = "eol",
              hl_mode = "combine",
            })
          end
        end)
        require("copilot_cmp").setup({
          method = "getCompletionsCycling",
        })
      end,
    },

    -- デバッグ
    {
      "mfussenegger/nvim-dap",
      dependencies = {
        "nvim-neotest/nvim-nio",
        "rcarriga/nvim-dap-ui",
        "nvim-telescope/telescope-dap.nvim",
      },
      event = "LspAttach",
      config = function()
        -- Debugging
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "<Leader>b", "<cmd>lua require('dap').toggle_breakpoint()<CR>", bufopts)
        vim.keymap.set("n", "<Leader>bc", "<cmd>lua require('dap').continue()<CR>", bufopts)
        vim.keymap.set("n", "<Leader>bi", "<cmd>lua require('dap').step_into()<CR>", bufopts)
        vim.keymap.set("n", "<Leader>bo", "<cmd>lua require('dap').step_over()<CR>", bufopts)
        vim.keymap.set("n", "<Leader>br", "<cmd>lua require('dap').clear_breakpoints()<CR>", bufopts)
        vim.keymap.set("n", "<Leader>bu", "<cmd>lua require('dapui').toggle()<CR>", bufopts)

        require("dapui").setup({
          icons = { expanded = "▾", collapsed = "▸" },
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

        require("telescope").load_extension("dap")
      end,
    },

    -- LSP ポップアップ
    {
      "rmagatti/goto-preview",
      event = "VeryLazy",
      config = function()
        require("goto-preview").setup({
          height = 40,
          width = 160,
        })

        -- LSP Popup
        vim.keymap.set("n", "<Leader>d", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", bufopts)
        vim.keymap.set("n", "<Leader>i", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", bufopts)
        vim.keymap.set("n", "<Leader>t", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", bufopts)
      end,
    },
  },
})
