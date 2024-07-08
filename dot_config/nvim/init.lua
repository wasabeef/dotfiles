---@diagnostic disable: undefined-global

-- ---------------------------------------------------------
-- Lazy.nvim セットアップ
-- ---------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- パフォーマンス
vim.loader.enable()

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
-- ステータス行を常に表示
vim.o.laststatus = 2
-- ファイル名補完
vim.o.wildmode = "list:longest"
-- 空白文字の表示
vim.o.list = true
vim.o.listchars = "tab:▸-"
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
-- LineLength 80 に色を付ける
vim.o.colorcolumn = "80"

if vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 then
  vim.o.shell = "pwsh"
  vim.o.shellcmdflag = "-c"
end

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
vim.api.nvim_set_keymap("v", "<C-p>", '"0p', { silent = true })

-- Spaceを押した後にrを押すと :%s/// が自動で入力される
-- vim.api.nvim_set_keymap('n', '<Leader>r', ':%s///g<Left><Left><Left>', { noremap = true })

-- コマンドラインウィンドウ (:~)
-- 入力途中での上下キーでヒストリー出すのを Ctrl+n/p にも割り当て
vim.api.nvim_set_keymap("c", "<C-n>", 'wildmenumode() ? "\\<c-n>" : "\\<down>"', { expr = true })
vim.api.nvim_set_keymap("c", "<C-p>", 'wildmenumode() ? "\\<c-p>" : "\\<up>"', { expr = true })
-- ---------------------------------------------------------

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

-- 前回開いたファイルのカーソル位置を復旧する
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   group = vim.api.nvim_create_augroup("restore_cursor", { clear = true }),
--   pattern = "*",
--   callback = function()
--     local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
--     if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
--       vim.api.nvim_win_set_cursor(0, { row, col })
--     end
--   end,
-- })

-- LSP
-- nvim-lspconfig と flutter-tools で利用する
vim.opt.completeopt = { "menu", "menuone", "noselect" }
local global_on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  -- LSP Debugging
  vim.keymap.set("n", "<Leader>k", vim.lsp.buf.hover, bufopts)
  -- vim.keymap.set('n', '<Leader>f', vim.lsp.buf.formatting, bufopts) -- use ale
  vim.keymap.set("n", "<Leader>r", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<Leader>dd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "<Leader>D", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "<Leader>ii", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<Leader>tt", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<Leader>n", vim.lsp.buf.rename, bufopts)
  -- vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<Leader>a", "<cmd>lua require('actions-preview').code_actions()<CR>", bufopts)
  vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, bufopts)
  vim.keymap.set("n", "<Leader>]", vim.diagnostic.goto_next, bufopts)
  vim.keymap.set("n", "<Leader>[", vim.diagnostic.goto_prev, bufopts)

  -- Debugging
  vim.keymap.set("n", "<Leader>b", "<cmd>lua require('dap').toggle_breakpoint()<CR>", bufopts)
  vim.keymap.set("n", "<Leader>bc", "<cmd>lua require('dap').continue()<CR>", bufopts)
  vim.keymap.set("n", "<Leader>bi", "<cmd>lua require('dap').step_into()<CR>", bufopts)
  vim.keymap.set("n", "<Leader>bo", "<cmd>lua require('dap').step_over()<CR>", bufopts)
  vim.keymap.set("n", "<Leader>br", "<cmd>lua require('dap').clear_breakpoints()<CR>", bufopts)
  vim.keymap.set("n", "<Leader>bu", "<cmd>lua require('dapui').toggle()<CR>", bufopts)
end

require("lazy").setup({
  spec = {
    -- カラー
    {
      "EdenEast/nightfox.nvim",
      lazy = false,
      config = function()
        vim.cmd("colorscheme duskfox")
      end,
    },

    -- スタート画面
    {
      "goolord/alpha-nvim",
      event = "VimEnter",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        dashboard.section.header.val = {
          -- Using img2art
          [[⣺⣿⣿⣿⣿⣿⣿⡿⠿⣿⠛⣧⣟⣤⣯⡽⢛⠛⠘⣏⢄⠚⠏⣿⠻⣶⣿⢟⣟⢛⣏⣿⣽⣿⣿⣿⣿⣯⣿⡛⠿⠿⢶⣽⣿⣿⣿⢿⣿⣿⢿⢿⠿⠟⢹⣿⠷⣋⣲⠿⢶⠦⢯⡀⢰⢚⡟⠷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
          [[⠛⠟⠛⣿⣿⣿⡷⢶⣤⣤⡾⣟⣑⠀⡍⢈⠀⢇⠠⠈⡠⠐⡤⡅⢩⠺⢿⣿⡷⢿⣷⣿⢿⡿⡧⣔⣤⣉⣾⢿⢿⣷⣦⣉⣽⡭⣽⠧⡐⠰⢱⡚⠒⠐⠓⠈⠛⠈⠉⠭⠑⠈⠀⠠⠀⠐⠘⠭⠿⣋⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡛⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
          [[⣿⢠⣼⠿⣩⣦⡼⠟⠉⠁⣄⣌⢁⠦⠚⠈⠔⠤⠡⠶⠺⠂⠅⠰⣀⢀⣰⣿⣽⣷⣪⠀⣽⠄⣚⠈⣀⣾⡰⣶⣦⣜⠝⢯⣟⠑⣦⣲⠯⠁⠈⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⢔⣀⠰⣇⠊⣿⣛⢿⣿⣿⣿⣿⣏⣩⣿⣿⣿⣿⣿⣿⣿⣿⣦⣌⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
          [[⣿⢸⢯⡾⣹⠟⠛⠀⠀⢘⠉⠙⠀⠀⠀⠀⠈⠐⠀⠊⠀⠀⠀⠀⠀⢨⣿⣽⡷⢏⠛⠛⠖⣪⡍⠀⢀⡉⢻⣻⣿⣿⣽⣞⠿⢲⡥⢔⣙⣧⣴⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠂⡀⣋⠲⢻⣃⣮⣿⠙⢱⡆⢀⡌⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
          [[⣿⣞⡿⢇⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠩⢛⡿⢩⣶⣀⢀⡄⢠⡚⠿⣦⠾⠣⠾⣯⢿⡝⠍⢛⣟⢦⣿⣱⠟⠇⡖⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠂⠀⢈⣉⠡⢉⣸⠩⢮⣥⠌⠛⠛⠁⠿⣿⡫⣭⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
          [[⣿⣿⣷⠨⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣾⣿⣇⠽⢟⣋⣭⣤⣵⡶⡶⣶⡾⣿⣿⣶⣮⡹⢾⣷⣭⣿⣼⣿⠠⠐⢆⢧⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠄⠠⠀⠚⢃⠉⢥⣡⣗⢚⢛⠛⢿⣷⣦⡑⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
          [[⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠤⢸⣿⡾⣩⣶⣿⣿⡹⠋⢁⡠⠞⠣⡦⢸⣿⣿⣿⣿⡘⣽⡿⢿⢿⡿⣛⣫⢴⠶⠓⢺⡆⠀⠀⠀⠀⠀⠀⡀⠠⠀⠀⠊⠀⠀⠉⠀⠀⠈⡗⠞⡄⡔⢍⠀⣸⣿⣿⣷⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⠛⠛⠿⠿⠿⠿⣿⣿⣿⣿⣿⣿⣿]],
          [[⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⢀⣄⢏⣾⣿⣿⣷⣼⣶⡁⠹⢇⠂⣩⣴⣿⣿⣿⣿⣿⣿⢈⣷⣾⣿⣿⣿⣿⣼⣮⠹⠑⢼⡄⠃⠠⠬⢄⢌⢈⠀⠀⠀⠀⠀⠀⠀⢰⣴⣿⣿⣤⣢⣂⢠⣾⣿⣿⣿⣿⣀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⣿⣿⣿⣿⣷⣦⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⢁⣤⣾⢯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡾⣿⣿⣿⣿⣿⣿⣿⡿⢢⣿⣿⣿⣾⣿⣶⣞⢻⣿⡑⡄⠱⡭⠏⠄⠐⠀⠃⠁⠀⠀⢠⣤⣴⣶⢹⣿⣿⣿⣿⣿⣿⣾⣿⣿⣿⠟⣥⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣄⢀⠀⠀⠀⠀⠀⠀]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠠⢼⣯⣿⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⣿⣿⣿⣶⣿⣿⣿⣍⣿⠣⣿⣿⣾⣭⣴⡇⡈⠐⣀⣐⣤⣤⣴⣶⣿⣿⣿⣿⣿⣿⡞⣿⣿⣿⣿⣿⡿⢇⣻⣩⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣠⣦⣴⡀⠀⠀]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣴⣤⣀⠀⠀⠀⢀⣀⣿⣿⣿⣿⣮⣿⣿⣻⣻⣿⣿⣿⣿⣿⣿⣿⠻⡿⢿⡿⣿⣿⡿⣏⠙⡿⡠⡍⣿⣴⢯⣵⣔⡻⢯⣽⣾⣗⢿⣽⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⣭⣥⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣾]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⣂⢳⣾⣯⣿⣿⣾⠗⠻⢿⣿⣛⠟⣋⠉⢈⣃⣙⣢⣏⠦⣬⣿⣿⣿⣷⣷⣶⢶⣾⡿⠺⣿⣿⣿⡺⣿⣓⣖⣳⡝⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⠿⠿⠛⠿⠟⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⡀⠩⢹⠞⣿⣟⣡⡉⠚⠈⠋⢁⣄⣭⣶⡨⠖⠺⣍⣹⣛⠙⢷⣏⠭⣾⣿⠯⠻⠿⢋⡛⢢⡺⠼⣿⠺⣷⣶⣏⢻⡞⣞⣳⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠉⠉⡿⠗⠈⢻⣿⣿⣶⡀⠀⠀⠀⢀⠀⣳⡌⠉⠹⣿⣿⣿⣿⣿⣿⠿⣿⣿⣿⣿⣿⣿⣷⡀]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⢡⣾⠻⠇⠀⡙⠁⣠⣶⣴⡞⣹⡿⣻⢵⣷⠾⢏⣿⠟⡹⡟⠑⠋⢦⡍⠄⡀⠀⠂⠀⠁⠘⠛⢧⢍⡇⣼⣿⡿⣿⣶⡽⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⣸⣿⣿⣿⣷⣦⣴⣶⡓⢸⣿⣷⡄⠀⠛⣿⣿⣿⡟⠁⠈⠙⣿⣿⣿⣿⣿⣿⡇]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣴⡿⠗⢀⠀⠒⢀⣽⣿⠛⢉⣘⡕⠒⠀⡁⠏⠀⠀⠀⠐⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠅⠈⠣⠞⢿⣄⠹⣿⠿⣿⣿⣿⣿⣿⣿⣿⡿⠻⢷⣽⣿⣿⡻⠿⢿⣿⢧⣄⣠⣄⣼⣿⣿⣿⣿⣿⣿⣿⣿⣲⣾⣿⣿⣶⣄⠰⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠀⠀⣠⣿⡟⢉⡉⠁⠘⠙⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣄⠘⠧⢧⡺⠳⣶⣾⣿⣿⣿⠋⠁⠀⠰⣾⣿⣿⣿⣿⣷⣶⠄⠉⢉⠙⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡯⠉⠐⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣠⡄⠀⢰⡿⠳⠃⠀⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠨⠈⠿⠰⢞⠀⢻⣿⣿⡿⠋⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⠋⣤⣄⣤⣤⣤⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠤⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣉⠃⠀⢰⡏⣴⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣰⣿⣿⣿⣆⠀⢠⠀⢠⣸⣿⣶⡄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠰⠀⠀⢚⡇⣿⣧⣀⢯⠉⠃⠀⠀⠀⠀⠉⠘⢛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠅⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠦⠀⢀⣸⠄⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⡁⠑⠐⣶⣿⣿⣿⣿⣾⣶⣶⣶⣶⣂⡀⠀⠀⠀⠀⠀⢨⢰⣿⣿⣯⠈⠀⠀⠀⠀⠀⠀⠀⠀⠒⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣾⠄⠀⢈⡜⠁⠀⠀⠀⠀⠀⠀⠀⣀⣴⣶⣴⣿⣿⣿⣿⣿⣿⠏⠉⠁⢀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠐⣸⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⡿⠛⠛⠉⠻⢿⣿⣿⣯⣉⠋⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⡟⠁⠀⠈⣷⠀⠪⠃⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⡖⠀⡡⣀⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⢀⠀⠀⣾⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠉⠀⠀⠀⠀⠀⠀⠀⠈⠘⠁⠀⠁⠀⠀⠀⠀⠀⠀⠀⣠⣤⣤⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀]],
          [[⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⢹⣶⡀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⠇⡈⢀⠀⠙⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⢠⣾⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⣠⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣀⢠⡄⠀⠀⠀⢹⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⣤⣿]],
          [[⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠈⣿⣗⡀⠀⡀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⠋⠐⠊⠄⡅⠠⠈⠻⣿⣿⣿⣿⣿⣿⣿⣏⠀⠀⠀⢠⣠⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⣿⡿⠇⠀⠀⠀⠀⠀⠀⠀⢴⠀⠀⠀⢀⠀⠀⠀⣤⣨⣿⣿⣷⠀⠀⠀⠀⠙⢿⣿⡿⣿⣿⡿⠀⠀⠀⣼⣦⣿⣿]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠘⢿⣇⡔⠁⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⡟⠀⠢⠀⠈⠀⠀⠀⠀⣽⣿⣿⣿⣿⣿⣿⠁⠀⠀⠀⠸⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⢠⣿⣿⣾⣿⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠘⠁⠀⠀⠀⠀⣿⣿⣿⣿]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⢿⡮⡄⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⡇⠀⠀⠀⡀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⣰⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠈⢷⣿⡆⠀⠀⠀⠀⠀⠀⠺⣿⣿⣿⣿⣿⣧⣠⣦⣷⣴⣖⣶⣆⣠⣾⣿⣿⣿⣿⣿⡟⠁⠀⠀⠀⣦⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣷⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣄⠀⠀⠈⢿⣷⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠿⠟⣿⣿⣿⣿⡇⠀⠀⠀⣰⡘⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠈⣿⡀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⠀⠀⠈⢩⢿⢿⣿⠻⡂⠀⠀⠀⣿⣿⣿⣿⠃⠀⠀⣰⡟⠀⠀⢀⣀⣀⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣿⣿]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⠀⠘⣗⠀⠀⠀⠀⠀⠀⣹⣿⣿⣿⠀⠀⠀⠈⠈⠀⠁⠁⠀⠀⠁⢀⣿⣿⣿⡏⠀⠀⣴⡟⠀⢠⣾⣿⣿⣿⣯⠀⠀⠀⠀⠀⠀⡀⠆⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣦⣀⣀⣤⣾⣿⣿⣿⣿⣿⣿⣿]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠃⠀⠈⠄⠀⠀⠀⠀⠀⣼⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣿⠛⠀⠀⣰⠏⠀⣰⣿⣿⣿⣿⠟⠃⠀⠀⠀⠀⢀⣾⠃⠀⠀⠀⠀⠀⢀⣠⣴⣿⣿⣿⡇⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⠴⢠⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⢿⣿⣦⣀⣀⣀⣀⣀⣀⣴⣿⣿⣿⣿⣧⣄⣴⠏⠀⢰⣿⣿⣿⠟⠉⠀⠀⠀⠀⣀⣸⣾⣿⣀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣶⣦⣄⣀⡀⠀⢀⣀⠀⠀⠀⠀⠀⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣧⡈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠀⠀⣴⠙⠛⠉⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⠇⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣦⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡃⠀⠀⠀⠀⠀⠀⠠⡄⠀⠉⠛⠿⣿⣿⣷⣬⡿⠉⠀⠀⠀⢀⣽⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⣾⣿⠀⣶⣶⣦⣄⠀⢀⣾⣿⣿⣿⣿⣿⡏⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⡶⠄⠀⠀⠀⠀⠑⠄⠀⠀⠀⠀⠉⠙⠛⠛⠛⠶⠶⠿⠿⠿⠿⠿⠿⠟⠛⠉⠀⠀⠀⠀⠉⠉⠺⢿⣿⣿⣷⣶⣾⣿⣿⣿⣿⣿⠏⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⣿⢻⣿⡿⢣⡶⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠀⠀⠀⠀⣠⣤⠀⢀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠻⢻⣿⣿⣿⡟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⡟⠁⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⢀⠀⢀⣠⣤⣤⣴⣷⣬⣶⣶⣶⡶⠇⢠⣶⣿⢿⣿⣶⣉⠀⠈⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣼⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⢨⣷⢸⣿⣿⡤⠸⠀⣠⣠⣤⣶⣾⣷⣧⣤⣖⣦⣤⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣜⠋⣠⣾⣿⣿⣿⣷⣤⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣈⣽⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣄⣻⣿⣿⠋⣿⣿⣿⣷⣦⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        }

        dashboard.section.buttons.val = {
          -- dashboard.button("e", "   New file",       ":ene <BAR> startinsert <CR>"),
          dashboard.button("f", "   Find file", ":Telescope find_files<CR>"),
          dashboard.button("g", "󰱼   Find word", ":Telescope live_grep<CR>"),
          dashboard.button("r", "󰈚   Recent", ":Telescope oldfiles<CR>"),
          dashboard.button("i", "   Edit init.lua", ":e $MYVIMRC <CR>"),
          dashboard.button("z", "   Edit .zshrc", ":e ~/.zshrc <CR>"),
          dashboard.button("w", "   Edit .wezterm.lua", ":e ~/.wezterm.lua <CR>"),
          dashboard.button("m", "󱌣   Mason", ":Mason<CR>"),
          dashboard.button("l", "󰒲   Lazy", ":Lazy<CR>"),
          dashboard.button("u", "󰂖   Update plugins", "<cmd>lua require('lazy').sync()<CR>"),
          -- dashboard.button("q", "   Quit NVIM", ":qa<CR>"),
        }

        dashboard.section.footer.val = { "⚡" .. require("lazy").stats().loaded .. " plugins loaded." }
        dashboard.opts.opts.noautocmd = true
        alpha.setup(dashboard.opts)
      end,
    },

    -- スクリーンセイバー
    {
      "folke/drop.nvim",
      event = "VeryLazy",
      opts = {
        theme = "auto",
        screensaver = 1000 * 60 * 5, -- 5 minutes
        filetypes = { "alpha" },
        winblend = 100,
      },
    },

    -- スムーススクロール
    {
      "karb94/neoscroll.nvim",
      event = "VeryLazy",
      config = function()
        local neoscroll = require("neoscroll")
        local keymap = {
          ["<C-u>"] = function()
            neoscroll.ctrl_u({ duration = 60 })
          end,
          ["<C-d>"] = function()
            neoscroll.ctrl_d({ duration = 60 })
          end,
          ["<C-b>"] = function()
            neoscroll.ctrl_b({ duration = 140 })
          end,
          ["<C-f>"] = function()
            neoscroll.ctrl_f({ duration = 140 })
          end,
        }

        local modes = { "n", "v", "x" }
        for key, func in pairs(keymap) do
          vim.keymap.set(modes, key, func)
        end
      end,
    },

    -- ステータスバー
    {
      "vim-airline/vim-airline",
      dependencies = "vim-airline/vim-airline-themes",
      event = "VeryLazy",
    },

    -- ウィンドウサイズ変更
    {
      "simeji/winresizer",
      event = "VeryLazy",
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
      event = "InsertEnter",
      config = true,
    },

    -- EditorConfig
    {
      "editorconfig/editorconfig-vim",
      event = "VeryLazy",
    },

    -- 引数の入れ替え g> g< gs
    {
      "machakann/vim-swap",
      event = "VeryLazy",
    },

    -- Incremental Search
    {
      "haya14busa/is.vim",
      event = "VeryLazy",
    },

    -- リアルタイム置換
    {
      "markonm/traces.vim",
      event = "VeryLazy",
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
            "dirbuf",
            "dirvish",
            "fugitive",
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

    -- 空白文字ハイライト
    {
      "shellRaining/hlchunk.nvim",
      event = { "BufReadPre", "BufNewFile" },
      opts = {
        chunk = {
          enable = true,
          use_treesitter = true,
        },
        indent = { enable = true },
      },
    },

    -- インラインターミナル
    {
      "akinsho/toggleterm.nvim",
      event = "VeryLazy",
      keys = {
        { "<C-t>f", "<Cmd>ToggleTerm direction=float<CR>" },
        { "<C-t>v", "<Cmd>ToggleTerm direction=vertical<CR>" },
        { "<C-t>h", "<Cmd>ToggleTerm direction=horizontal<CR>" },
      },
      opts = {
        size = function(term)
          return ({
            horizontal = vim.o.lines * 0.3,
            vertical = vim.o.columns * 0.35,
          })[term.direction]
        end,
        open_mapping = "<C-t>",
        direction = "float",
      },
    },

    -- コマンドと検索 UI
    {
      "folke/noice.nvim",
      dependencies = {
        "MunifTanjim/nui.nvim",
      },
      event = "VeryLazy",
      config = function()
        require("noice").setup({
          lsp = { progress = { enabled = false } },
          messages = { enabled = false },
          notify = { enabled = false },
          popupmenu = { enabled = false },
          health = { enabled = false },
          cmdline = {
            enabled = true,
          },
        })
      end,
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
      "akinsho/bufferline.nvim",
      dependencies = "nvim-tree/nvim-web-devicons",
      event = { "BufRead", "BufNewFile" },
      config = function()
        vim.opt.termguicolors = true
        require("bufferline").setup({
          options = {
            separator_style = "slant",
            numbers = "ordinal",
            diagnostics = "nvim_lsp",
            max_name_length = 25,
            tab_size = 25,
            modified_icon = "󰆓",
            close_icon = "",
            left_trunc_marker = "",
            right_trunc_marker = "",
          },
        })
        vim.api.nvim_set_keymap("n", "[[", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "]]", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "[]", ":BufferLinePick<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "][", ":BufferLinePickClose<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "\\][", ":BufferLineCloseLeft<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "\\[]", ":BufferLineCloseRight<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "\\\\", ":bd<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "\\\\ ", ":bp<CR>", { noremap = true, silent = true })
      end,
    },

    -- スクロールバー
    {
      "petertriho/nvim-scrollbar",
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("scrollbar").setup({
          handle = { color = "#445588" },
        })
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
          signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
          numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
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

    -- Lint
    {
      "dense-analysis/ale",
      event = "VeryLazy",
      config = function()
        vim.g.ale_lint_on_enter = 0
        vim.g.ale_sign_column_always = 1
        vim.g.ale_lint_on_save = 0
        vim.g.ale_linters = {
          markdown = { "textlint" },
          json = { "jq", "jsonlint", "cspell" },
          yaml = { "yamllint" },
          go = { "gofmt", "gopls" },
        }
        vim.g.ale_fixers = {
          ["*"] = { "trim_whitespace" },
          lua = { "stylua" },
          sh = { "shfmt" },
          bash = { "shfmt" },
          zsh = { "shfmt" },
          markdown = { "prettier" },
          yaml = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          -- less = {'prettier'},
          -- scss = {'prettier'},
          json = { "prettier" },
          -- xml = {'xmllint'},
          -- vue = {'prettier'},
          -- svelte = {'prettier'},
          -- astro = {'prettier'},
          javascript = { "prettier", "eslint" },
          javascriptreact = { "prettier", "eslint", "stylelint" },
          typescript = { "prettier", "tslint", "eslint" },
          typescriptreact = { "prettier", "tslint", "eslint", "stylelint" },
          java = { "eclipselsp" },
          kotlin = { "ktlint" },
          dart = { "dart-format" },
          go = { "gofmt", "goimports" },
          graphql = { "prettier" },
        }
        vim.api.nvim_set_keymap("n", "<Leader>f", ":ALEFix<CR>", { noremap = true, silent = true })
      end,
    },

    -- ファイルツリー
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
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
          vim.keymap.set("n", "<c-t>", "<cmd>ToggleTerm<CR>", opts("ToggleTerm"))
        end

        vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

        require("nvim-tree").setup({
          on_attach = on_attach,
          view = {
            float = {
              enable = true,
              open_win_config = {
                height = 65,
                width = 45,
              },
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
      end,
    },

    -- コードハイライト
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      event = "VeryLazy",
      config = function()
        require("nvim-treesitter.configs").setup({
          -- ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
          sync_install = false,
          auto_install = true,
          -- ignore_install = { "dart" },
          highlight = {
            enable = true,
            -- disable = { "dart" },
            disable = function(_, buf)
              local max_filesize = 100 * 1024 -- 100 KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                return true
              end
            end,
            additional_vim_regex_highlighting = false,
          },
        })
      end,
    },

    -- コピーハイライト
    {
      "machakann/vim-highlightedyank",
      event = "VeryLazy",
    },

    -- デバッグ
    {
      "mfussenegger/nvim-dap",
      dependencies = {
        "nvim-neotest/nvim-nio",
        "rcarriga/nvim-dap-ui",
      },
      event = "VeryLazy",
      config = function()
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
      end,
    },

    -- fzf ファイル・コマンド検索
    {
      "nvim-telescope/telescope.nvim", -- tag = '0.1.8',
      dependencies = {
        "nvim-lua/plenary.nvim",
        "mfussenegger/nvim-dap",
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-media-files.nvim",
        "dimaportenko/telescope-simulators.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-dap.nvim",
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          build = "make",
        },
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
          "<C-p>",
          "<cmd>lua require('telescope.builtin').oldfiles()<CR>",
          { noremap = true, silent = true }
        )
        vim.api.nvim_set_keymap(
          "n",
          "<C-g>",
          "<cmd>lua require('telescope.builtin').live_grep()<CR>",
          { noremap = true, silent = true }
        )
        vim.api.nvim_set_keymap(
          "n",
          "<C-x>",
          "<cmd>lua require('telescope.builtin').commands()<CR>",
          { noremap = true, silent = true }
        )
        vim.api.nvim_set_keymap(
          "n",
          "<C-z>",
          "<cmd>lua require('telescope.builtin').keymaps()<CR>",
          { noremap = true, silent = true }
        )
        vim.api.nvim_set_keymap(
          "n",
          "<C-;>",
          "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
          { noremap = true }
        )
        vim.api.nvim_set_keymap("n", "<Leader>h", "<cmd>Telescope notify<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap(
          "n",
          "<Leader>s",
          "<cmd>Telescope simulators run<CR>",
          { noremap = true, silent = true }
        )

        require("telescope").setup({
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
            extensions = {
              file_browser = {
                theme = "ivy",
                hijack_netrw = true,
                -- hidden = true,
                git_status = true,
                respect_gitignore = false,
              },
              fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
              },
            },
          },
        })
        require("telescope").load_extension("ui-select")
        require("telescope").load_extension("flutter")
        require("telescope").load_extension("notify")
        require("telescope").load_extension("dap")
        require("telescope").load_extension("media_files")
        require("telescope").load_extension("file_browser")
        require("telescope").load_extension("fzf")
        require("simulators").setup({
          android_emulator = true,
          apple_simulator = true,
        })
      end,
    },

    -- Flutter
    {
      "akinsho/flutter-tools.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim",
      },
      event = "VeryLazy",
      config = function()
        require("flutter-tools").setup({
          flutter_path = nil,
          flutter_lookup_cmd = "asdf where flutter",
          fvm = false,
          root_patterns = { ".git", "pubspec.yaml" },
          ui = {
            border = "rounded",
            -- notification_style = 'native',
          },
          decorations = {
            statusline = {
              app_version = true,
              device = true,
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
            open_cmd = "tabedit",
          },
          dev_tools = {
            autostart = false,
            auto_open_browser = false,
          },
          outline = {
            open_cmd = "rightbelow 50vnew",
            auto_open = false,
          },
          lsp = {
            color = {
              enabled = false,
              background = false,
              background_color = nil,
              foreground = false,
              virtual_text = true,
              virtual_text_str = "⚡",
            },
            on_attach = function(client, bufnr)
              local bufopts = { noremap = true, silent = true, buffer = bufnr }

              vim.keymap.set(
                "n",
                "<Leader>m",
                "<cmd>lua require('telescope').extensions.flutter.commands()<CR>",
                bufopts
              )
              vim.keymap.set("n", "<Leader>o", "<cmd>FlutterOutlineToggle<CR>", bufopts)

              local function find_flutter_files()
                local flutter_sdk_path = vim.fn.system("asdf where flutter | tr -d '\\n'")
                require("telescope.builtin").find_files({
                  prompt_title = "Find Flutter Files",
                  search_dirs = { flutter_sdk_path },
                })
              end
              vim.api.nvim_create_user_command("TelescopeFindFlutterFiles", find_flutter_files, {})
              vim.keymap.set("n", "<C-i>", "<cmd>TelescopeFindFlutterFiles<CR>", { noremap = true, silent = true })

              global_on_attach(client, bufnr)
            end,
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
              enableSnippets = false,
              updateImportsOnRename = true,
            },
          },
        })
      end,
    },

    -----------------------------------------------------------------------
    -- LSP
    -----------------------------------------------------------------------

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

    -- エラーメッセージ
    {
      "folke/trouble.nvim",
      event = "VeryLazy",
      opts = {
        position = "bottom",
        height = 5,
        -- auto_open = true,
        auto_close = true,
      },
      cmd = "Trouble",
      keys = {
        {
          "<leader>te",
          "<cmd>Trouble diagnostics toggle<cr>",
          desc = "Diagnostics (Trouble)",
        },
        -- vim.keymap.set('n', '<Leader>te', "<cmd>TroubleToggle<CR>", bufopts)
        -- vim.keymap.set('n', '<Leader>tw', "<cmd>TroubleToggle workspace_diagnostics<CR>", bufopts)
        -- vim.keymap.set('n', '<Leader>td', "<cmd>TroubleToggle document_diagnostics<CR>", bufopts)
        -- vim.keymap.set('n', '<Leader>tq', "<cmd>TroubleToggle quickfix<CR>", bufopts)
        -- vim.keymap.set('n', '<Leader>tl', "<cmd>TroubleToggle loclist<CR>", bufopts)
        -- vim.keymap.set('n', '<Leader>tR', "<cmd>TroubleToggle lsp_references<CR>", bufopts)

        -- {
        --   "<leader>xX",
        --   "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        --   desc = "Buffer Diagnostics (Trouble)",
        -- },
        -- {
        --   "<leader>cs",
        --   "<cmd>Trouble symbols toggle focus=false<cr>",
        --   desc = "Symbols (Trouble)",
        -- },
        -- {
        --   "<leader>cl",
        --   "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        --   desc = "LSP Definitions / references / ... (Trouble)",
        -- },
        -- {
        --   "<leader>xL",
        --   "<cmd>Trouble loclist toggle<cr>",
        --   desc = "Location List (Trouble)",
        -- },
        -- {
        --   "<leader>xQ",
        --   "<cmd>Trouble qflist toggle<cr>",
        --   desc = "Quickfix List (Trouble)",
        -- },
      },
    },

    -- LSP Status
    {
      "j-hui/fidget.nvim",
      event = {
        "LspAttach",
      },
      opts = {
        progress = {
          display = {
            progress_icon = {
              pattern = "moon",
            },
          },
        },
        notification = {
          window = {
            border = "rounded",
          },
        },
      },
      integration = {
        ["nvim-tree"] = {
          enable = true,
        },
      },
    },

    -- LSP Symbol Search
    {
      "liuchengxu/vista.vim",
      event = "VeryLazy",
      config = function()
        vim.g.vista_default_executive = "nvim_lsp"
        vim.g.vista_renderer_enable_icon = 1
        vim.g.vista_sidebar_position = "rightbelow 50vnew"
        vim.api.nvim_set_keymap("n", "<Leader>v", "<cmd>Vista!!<CR>", { noremap = true, silent = true })
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

    -- LSP Management
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
      },
      event = "VeryLazy",
      config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

        require("mason").setup()
        require("mason-lspconfig").setup()
        require("mason-lspconfig").setup_handlers({
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = global_on_attach,
              capabilities = capabilities,
            })
          end,
        })

        -- false : do not show error/warning/etc.. by virtual text
        vim.lsp.handlers["textDocument/publishDiagnostics"] =
          vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { separator = true })
        vim.lsp.handlers["textDocument/signatureHelp"] =
          vim.lsp.with(vim.lsp.handlers.signature_help, { separator = true })
      end,
    },

    -- 非アクティブな LSP クライアントを自動的に停止
    {
      "zeioth/garbage-day.nvim",
      dependencies = "neovim/nvim-lspconfig",
      event = "VeryLazy",
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

        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
        "hrsh7th/vim-vsnip-integ",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lsp-document-symbol",

        "onsails/lspkind-nvim",
      },
      event = "VeryLazy",
      config = function()
        local cmp = require("cmp")
        local types = require("cmp.types")
        local lspkind = require("lspkind")

        lspkind.init({
          symbol_map = {
            Copilot = "",
          },
        })

        cmp.setup({
          completion = {
            autocomplete = {
              types.cmp.TriggerEvent.TextChanged,
              types.cmp.TriggerEvent.TextChanged,
            },
            completeopt = "longest,menu,menuone,noselect,noinsert,preview",
            keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
            keyword_length = 1,
          },
          snippet = {
            expand = function(args)
              vim.fn["vsnip#anonymous"](args.body)
            end,
          },
          window = {
            completion = cmp.config.window.bordered({
              border = "single",
            }),
            documentation = cmp.config.window.bordered({
              border = "single",
            }),
          },
          formatting = {
            format = lspkind.cmp_format({
              mode = "symbol",
              maxwidth = 50,
              ellipsis_char = "...",
              before = function(_, vim_item)
                return vim_item
              end,
            }),
          },
          mapping = cmp.mapping.preset.insert({
            -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
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
          experimental = {
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

    -- LSP Navigation
    {
      "dnlhc/glance.nvim",
      event = "VeryLazy",
      config = function()
        -- Lua configuration
        local glance = require("glance")
        local actions = glance.actions

        glance.setup({
          height = 18, -- Height of the window
          zindex = 45,

          -- By default glance will open preview "embedded" within your active window
          -- when `detached` is enabled, glance will render above all existing windows
          -- and won't be restiricted by the width of your active window
          -- detached = true,

          -- Or use a function to enable `detached` only when the active window is too small
          -- (default behavior)
          detached = function(winid)
            return vim.api.nvim_win_get_width(winid) < 100
          end,

          preview_win_opts = { -- Configure preview window options
            cursorline = true,
            number = true,
            wrap = true,
          },
          border = {
            enable = false, -- Show window borders. Only horizontal borders allowed
            top_char = "―",
            bottom_char = "―",
          },
          list = {
            position = "right", -- Position of the list window 'left'|'right'
            width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
          },
          theme = { -- This feature might not work properly in nvim-0.7.2
            enable = true, -- Will generate colors for the plugin based on your current colorscheme
            mode = "auto", -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
          },
          mappings = {
            list = {
              ["j"] = actions.next, -- Bring the cursor to the next item in the list
              ["k"] = actions.previous, -- Bring the cursor to the previous item in the list
              ["<Down>"] = actions.next,
              ["<Up>"] = actions.previous,
              ["<Tab>"] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
              ["<S-Tab>"] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
              ["<C-u>"] = actions.preview_scroll_win(5),
              ["<C-d>"] = actions.preview_scroll_win(-5),
              ["v"] = actions.jump_vsplit,
              ["s"] = actions.jump_split,
              ["t"] = actions.jump_tab,
              ["<CR>"] = actions.jump,
              ["o"] = actions.jump,
              ["l"] = actions.open_fold,
              ["h"] = actions.close_fold,
              ["<leader>l"] = actions.enter_win("preview"), -- Focus preview window
              ["q"] = actions.close,
              ["Q"] = actions.close,
              ["<Esc>"] = actions.close,
              ["<C-q>"] = actions.quickfix,
              -- ['<Esc>'] = false -- disable a mapping
            },
            preview = {
              ["Q"] = actions.close,
              ["<Tab>"] = actions.next_location,
              ["<S-Tab>"] = actions.previous_location,
              ["<leader>l"] = actions.enter_win("list"), -- Focus list window
            },
          },
          hooks = {},
          folds = {
            fold_closed = "",
            fold_open = "",
            folded = true, -- Automatically fold list on startup
          },
          indent_lines = {
            enable = true,
            icon = "│",
          },
          winbar = {
            enable = true, -- Available strating from nvim-0.8+
          },
          use_trouble_qf = false, -- Quickfix action will open trouble.nvim instead of built-in quickfix list window
        })
      end,
    },

    -- LSP Copilot
    {
      "zbirenbaum/copilot.lua",
      dependencies = {
        "zbirenbaum/copilot-cmp",
      },
      event = "InsertEnter",
      cmd = "Copilot",
      config = function()
        require("copilot").setup({
          panel = {
            enabled = true,
            auto_refresh = false,
            keymap = {
              jump_prev = "[[",
              jump_next = "]]",
              accept = "<CR>",
              refresh = "gr",
              open = "<M-CR>",
            },
            layout = {
              position = "bottom", -- | top | left | right
              ratio = 0.4,
            },
          },
          suggestion = {
            enabled = true,
            auto_trigger = false,
            hide_during_completion = true,
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
          filetypes = {
            yaml = false,
            markdown = false,
            help = false,
            gitcommit = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            ["."] = false,
          },
          copilot_node_command = "node", -- Node.js version must be > 18.x
          server_opts_overrides = {},
        })
        require("copilot_cmp").setup({
          method = "getCompletionsCycling",
        })
      end,
    },
  },
  checker = { enabled = true },
})
