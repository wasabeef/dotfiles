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
Plug 'nvim-lua/plenary.nvim'

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

" コードハイライト
" e.g. :TSInstall <language_to_install>
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" ファイル・テキスト検索(Fuzzy Finder)
Plug 'nvim-telescope/telescope.nvim'

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
" LSP Flutter
Plug 'akinsho/flutter-tools.nvim'

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

" Exchange 
" nmap cx <Plug>(Exchange)
" xmap X <Plug>(Exchange)
" nmap cxc <Plug>(ExchangeClear)
" nmap cxx <Plug>(ExchangeLine)

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

lua << EOF
-- スクロール
require('neoscroll').setup()

-- gcc でコメントアウト
require('Comment').setup()

-- LSP
require('fidget').setup{}
-- https://zenn.dev/botamotch/articles/21073d78bc68bf
vim.opt.completeopt = "menu,menuone,noselect"
-- 1. Management
require('mason').setup()
require('mason-lspconfig').setup_handlers({ function(server)
  local opt = {
    -- -- Function executed when the LSP server startup
    on_attach = function(client, bufnr)
      local opts = { noremap=true, silent=true }
      -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      -- vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'

      -- keyboard shortcut
      vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
      vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
      vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
      vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
      vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
      vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
      vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
      vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
      vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
      vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
      vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
      vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
      -- LSP handlers
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
      )

    end,
    capabilities = require('cmp_nvim_lsp').update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  }
  require('lspconfig')[server].setup(opt)
end })
-- 3. completion (hrsh7th/nvim-cmp)
local cmp = require("cmp")
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
require('flutter-tools').setup{
  flutter_lookup_cmd = 'asdf where flutter',
  lsp = {
    settings = {
      analysisExcludedFolders = {
        vim.fn.expand("$HOME/.pub-cache"),
        vim.fn.expand("$HOME/.pub-cache"),
      }
    }
  }
}

-- Debugging
require("dapui").setup()
require('telescope').load_extension('dap')
require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
  }
}

-- for windows
-- https://github.com/neovim/neovim/issues/16957
if vim.fn.has('win64') == 1 or vim.fn.has('win32') == 1 then
  vim.opt.shellcmdflag = "-c"
end

-- lua end
EOF

colorscheme gotham256
