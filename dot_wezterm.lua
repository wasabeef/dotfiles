local wezterm = require 'wezterm'

local os = (function()
  if string.find(wezterm.target_triple, 'apple') then
    return 'macOS'
  elseif string.find(wezterm.target_triple, 'windows') then
    return 'windows'
  elseif string.find(wezterm.target_triple, 'linux') then
    return 'linux'
  end
end)()

-- Common settings
local config = wezterm.config_builder()

config.animation_fps = 120
config.max_fps = 120
config.prefer_egl = true
config.front_end = 'WebGpu'
config.webgpu_power_preference = 'HighPerformance'

-- window
config.adjust_window_size_when_changing_font_size = false
config.integrated_title_button_style = 'Windows'
config.window_decorations = 'RESIZE'
config.window_background_opacity = 1
config.window_padding = {
  left = '0.5cell',
  right = '0.5cell',
  top = '0.5cell',
  bottom = '0cell',
}
config.window_frame = {
  active_titlebar_bg = '#0F2536',
  inactive_titlebar_bg = '#0F2536',
  border_bottom_height = '0.5cell',
}

-- cursor
-- config.default_cursor_style = 'BlinkingBlock'
config.default_cursor_style = 'BlinkingUnderline'
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_blink_rate = 500
config.force_reverse_video_cursor = true

config.colors = {
  tab_bar = {
    background = '#282c34',
  },

  foreground = '#b9c0cb',
  background = '#282c34',

  cursor_bg = '#ffcc00',
  cursor_fg = '#282c34',
  cursor_border = '#ffcc00',

  selection_bg = '#b9c0ca',
  selection_fg = '#272b33',

  ansi = { '#41444d', '#fc2f52', '#25a45c', '#ff936a', '#3476ff', '#7a82da', '#4483aa', '#cdd4e0' },
  brights = { '#8f9aae', '#ff6480', '#3fc56b', '#f9c859', '#10b1fe', '#ff78f8', '#5fb9bc', '#ffffff' },
}

config.font = wezterm.font_with_fallback {
  'Cascadia Code',
  'Cascadia Mono',
  'JetBrains Mono',
}

-- macOS and Linux settings
if os == 'macOS' or os == 'linux' then
  config.font_size = 9
  config.initial_cols = 480
  config.initial_rows = 240

-- Windows settings
elseif os == 'windows' then
  -- config.default_prog = { 'msys2.cmd', '-defterm', '-no-start', '-full-path', '-shell', 'zsh' }
  config.font_size = 12.0
  config.initial_cols = 140
  config.initial_rows = 60
end

-- tab bar
config.tab_bar_at_bottom = true
config.tab_max_width = 50
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

-- Git コマンドを安全に実行するヘルパー関数
local function safe_git_command(cwd, ...)
  local success, stdout = wezterm.run_child_process {
    'git',
    '-C',
    cwd,
    ...,
  }
  if success then
    return stdout:gsub('\n', '')
  end
  return nil
end

-- Git URL からリポジトリ名を抽出
local function extract_repo_name_from_url(url)
  if not url then
    return nil
  end

  -- パターンマッチング
  -- https://github.com/JUMPTOON/app.git → app
  -- git@github.com:JUMPTOON/app.git → app
  local repo_name = url:match '([^/]+)%.git$' or url:match '([^/]+)$'

  return repo_name
end

-- プロセス名をアイコンに変換
-- Nerd Font のアイコンを使用
local function process_to_icon(process_name)
  if process_name == 'nvim' then
    return ''
  elseif process_name == 'zsh' then
    return ''
  elseif process_name == 'bash' then
    return '󱆃'
  elseif process_name == 'sl' then
    return '󰔬'
  elseif process_name == 'lazygit' or process_name == 'tig' then
    return ''
  elseif process_name == 'wezterm' then
    return ''
  elseif process_name == 'mcfly' then
    return ''
  elseif process_name == 'emu' then
    return '🦤'
  elseif string.match(process_name, '^python') then
    return '󰌠'
  elseif process_name == '' then
    return '🤖'
  else
    return process_name
  end
end

-- Git リポジトリ名を取得
local function get_git_repo_name(cwd_path)
  -- Git リポジトリかチェック
  if not safe_git_command(cwd_path, 'rev-parse', '--git-dir') then
    return nil
  end

  local repo_name = nil

  -- remote origin から取得
  local remote_url = safe_git_command(cwd_path, 'config', '--get', 'remote.origin.url')
  if remote_url then
    repo_name = extract_repo_name_from_url(remote_url)
  end

  -- 他の remote から取得
  if not repo_name then
    local remotes = safe_git_command(cwd_path, 'remote')
    if remotes and remotes ~= '' then
      local first_remote = remotes:match '([^\n]+)'
      if first_remote then
        remote_url = safe_git_command(cwd_path, 'config', '--get', 'remote.' .. first_remote .. '.url')
        if remote_url then
          repo_name = extract_repo_name_from_url(remote_url)
        end
      end
    end
  end

  -- toplevel のディレクトリ名
  if not repo_name then
    local toplevel = safe_git_command(cwd_path, 'rev-parse', '--show-toplevel')
    if toplevel then
      local bare_pattern = '([^/]+)%.bare'
      local git_pattern = '([^/]+)%.git'
      local dir_pattern = '([^/]+)$'

      if toplevel:match '%.bare/' or toplevel:match '%.git/' then
        repo_name = toplevel:match(bare_pattern) or toplevel:match(git_pattern)
      else
        repo_name = toplevel:match(dir_pattern)
      end
    end
  end

  -- 現在のディレクトリ名（最終手段）
  if not repo_name then
    local dir_name = cwd_path:match '([^/]+)$'
    if dir_name then
      repo_name = dir_name:gsub('%.git$', '')
    end
  end

  return repo_name
end

wezterm.on('format-tab-title', function(tab, tabs, panes, conf, hover, max_width)
  local background = '#282c34'
  local foreground = '#dcd7ba'
  local edge_background = '#282c34'

  if tab.is_active or hover then
    background = '#015db2'
    foreground = '#ffffff'
  end
  local edge_foreground = background

  -- タブタイトルを決定
  local title = ''

  -- タブのカスタムタイトルをチェック（リポジトリ名が設定されている場合）
  if tab.tab_title and tab.tab_title ~= '' then
    title = tab.tab_title
  else
    -- デフォルトのタイトルを取得してアイコンに変換
    title = process_to_icon(tab.active_pane.title)
  end

  -- Claude ステータス（元の無効化状態に戻す）
  local claude_emoji = ''

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = ' ' },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Attribute = { Intensity = tab.is_active and 'Bold' or 'Normal' } },
    { Text = ' ' .. title .. claude_emoji .. '  ' },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = '' },
  }
end)

-- 右下に Git ブランチを表示する
config.status_update_interval = 1000 -- 1 秒ごとに更新

-- Claude 関連の定数
local CLAUDE_CONSTANTS = {
  -- プロセスフィルタリング
  EXCLUDE_PATTERNS = { 'npm', 'node', 'claude%-code' },
  INVALID_TTY = '??',

  -- 実行判定の閾値
  CPU_ACTIVE_THRESHOLD = 1.0, -- CPU 使用率がこれ以上なら実行中
  CPU_CHECK_THRESHOLD = 0.1, -- FD チェックを行う最小 CPU 使用率
  FD_ACTIVE_THRESHOLD = 15, -- ファイルディスクリプタ数の閾値

  -- 表示
  EMOJI_IDLE = '🤖',
  EMOJI_RUNNING = '⚡',
  COLOR_ICON = '#FF6B6B',

  -- Git 表示色
  GIT_ICON_COLOR = '#569CD6',
  GIT_REPO_COLOR = '#808080',
  GIT_BRANCH_ICON_COLOR = '#4EC9B0',
  GIT_BRANCH_COLOR = '#909090',

  -- スペーシング
  SPACING_SMALL = '  ',
  SPACING_MEDIUM = '   ',
  SPACING_SINGLE = ' ',

  -- システムコマンド
  PS_PATH = '/bin/ps',
}

-- Claude ステータス表示
local function add_claude_status_to_elements(elements, tab_sessions, window)
  if not tab_sessions or #tab_sessions == 0 then
    return
  end

  -- タブ順序に従ってステータスを表示
  for i, tab_session in ipairs(tab_sessions) do
    if tab_session.has_claude then
      -- Claude タブの場合
      table.insert(elements, { Foreground = { Color = CLAUDE_CONSTANTS.COLOR_ICON } })
      local emoji = tab_session.running and CLAUDE_CONSTANTS.EMOJI_RUNNING or CLAUDE_CONSTANTS.EMOJI_IDLE
      table.insert(elements, { Text = emoji })
    else
      -- 非 Claude タブの場合
      table.insert(elements, { Foreground = { Color = '#8B4513' } })
      table.insert(elements, { Text = '🧔' })
    end

    -- 最後以外はスペースを追加
    if i < #tab_sessions then
      table.insert(elements, { Text = CLAUDE_CONSTANTS.SPACING_SINGLE })
    end
  end

  table.insert(elements, { Text = CLAUDE_CONSTANTS.SPACING_SINGLE })
end

-- プロセスの実行状態をチェックするヘルパー関数
local function check_process_running(pid)
  local ps_success, ps_stdout = wezterm.run_child_process {
    CLAUDE_CONSTANTS.PS_PATH,
    '-p',
    tostring(pid),
    '-o',
    'stat,pcpu,rss',
  }

  if not ps_success or not ps_stdout then
    return false
  end

  local lines = {}
  for line in ps_stdout:gmatch '[^\n]+' do
    table.insert(lines, line)
  end

  if #lines < 2 then
    return false
  end

  local data_line = lines[2]
  local stat, pcpu, rss = data_line:match '%s*(%S+)%s+(%S+)%s+(%S+)'

  if not stat then
    return false
  end

  -- 1. プロセス状態による判定
  if stat:match '^[RD]' then
    return true
  end

  local cpu_usage = tonumber(pcpu) or 0

  -- 2. CPU 使用率による判定
  if cpu_usage >= CLAUDE_CONSTANTS.CPU_ACTIVE_THRESHOLD then
    return true
  end

  -- 3. ファイルディスクリプタ数をチェック（コスト高いので条件付き）
  if cpu_usage > CLAUDE_CONSTANTS.CPU_CHECK_THRESHOLD then
    local lsof_success, lsof_stdout = wezterm.run_child_process {
      'lsof',
      '-p',
      tostring(pid),
      '-t',
    }
    if lsof_success and lsof_stdout then
      local fd_count = 0
      for _ in lsof_stdout:gmatch '[^\n]+' do
        fd_count = fd_count + 1
      end
      if fd_count > CLAUDE_CONSTANTS.FD_ACTIVE_THRESHOLD then
        return true
      end
    end
  end

  return false
end

-- TTY ベースで Claude プロセスを検出する関数
local function find_claude_by_tty(tty_name)
  if not tty_name or tty_name == '' then
    return nil
  end

  -- tty 名を正規化（/dev/ プレフィックスを削除）
  local tty = tty_name:gsub('^/dev/', '')

  -- この TTY で実行中の claude プロセスを検索
  local ps_success, ps_stdout = wezterm.run_child_process {
    '/bin/ps',
    '-t',
    tty,
    '-o',
    'pid,comm',
  }

  if not ps_success or not ps_stdout then
    return nil
  end

  -- 出力から claude プロセスを探す
  for line in ps_stdout:gmatch '[^\n]+' do
    local pid, comm = line:match '%s*(%d+)%s+(.+)'
    if pid and comm and comm:match 'claude' and not comm:match 'claude%-code' then
      return tonumber(pid)
    end
  end

  return nil
end

-- Claude プロセス情報を取得する関数
local function get_claude_status(window)
  -- エラーハンドリング
  if not window then
    return { tab_sessions = {} }
  end

  local success, result = pcall(function()
    local mux_window = window:mux_window()
    if not mux_window then
      return { tab_sessions = {} }
    end

    local tabs = mux_window:tabs()
    if not tabs then
      return { tab_sessions = {} }
    end

    local tab_sessions = {}

    for tab_index, tab in ipairs(tabs) do
      local has_claude = false
      local is_running = false
      local claude_pid = nil

      -- タブ内の全ペインをチェック
      local tab_success, panes = pcall(function()
        return tab:panes()
      end)
      if tab_success and panes then
        for _, pane in ipairs(panes) do
          -- TTY 名を取得
          local tty_success, tty_name = pcall(function()
            return pane:get_tty_name()
          end)

          if tty_success and tty_name then
            claude_pid = find_claude_by_tty(tty_name)

            if claude_pid then
              has_claude = true
              is_running = check_process_running(claude_pid)
              break -- タブ内に 1 つでも Claude があれば十分
            end
          end
        end
      end

      -- タブごとの Claude 情報を記録
      table.insert(tab_sessions, {
        tab_index = tab_index,
        has_claude = has_claude,
        running = is_running,
      })
    end

    return { tab_sessions = tab_sessions }
  end)

  if success then
    return result
  else
    -- エラー時は空のセッションを返す
    return { tab_sessions = {} }
  end
end

wezterm.on('update-right-status', function(window, pane)
  local elements = {}

  -- Claude ステータスを取得
  local claude_status = get_claude_status(window)

  local cwd = pane:get_current_working_dir()
  if not cwd then
    -- Claude ステータスのみ表示
    add_claude_status_to_elements(elements, claude_status.tab_sessions, window)
    window:set_right_status(wezterm.format(elements))
    return
  end

  local cwd_path = cwd.file_path

  -- Git リポジトリ名を取得
  local repo_name = get_git_repo_name(cwd_path)

  if not repo_name then
    -- Git リポジトリでない場合
    local mux_window = window:mux_window()
    if mux_window then
      local active_tab = mux_window:active_tab()
      if active_tab and active_tab:tab_id() == pane:tab():tab_id() then
        active_tab:set_title('')
      end
    end

    -- Git リポジトリでない場合は Claude ステータスのみ表示
    add_claude_status_to_elements(elements, claude_status.tab_sessions, window)
    window:set_right_status(wezterm.format(elements))
    return
  end

  -- ブランチ名を取得
  local branch = safe_git_command(cwd_path, 'branch', '--show-current')
  if not branch or branch == '' then
    local ref = safe_git_command(cwd_path, 'symbolic-ref', '--short', 'HEAD')
    if ref then
      branch = ref
    else
      branch = safe_git_command(cwd_path, 'rev-parse', '--short', 'HEAD')
    end
  end

  -- Git 表示
  if repo_name then
    table.insert(elements, { Foreground = { Color = CLAUDE_CONSTANTS.GIT_ICON_COLOR } })
    table.insert(elements, { Text = CLAUDE_CONSTANTS.SPACING_SMALL })
    table.insert(elements, { Foreground = { Color = CLAUDE_CONSTANTS.GIT_REPO_COLOR } })
    table.insert(elements, { Text = repo_name })

    if branch then
      table.insert(elements, { Foreground = { Color = CLAUDE_CONSTANTS.GIT_BRANCH_ICON_COLOR } })
      table.insert(elements, { Text = CLAUDE_CONSTANTS.SPACING_MEDIUM })
      table.insert(elements, { Foreground = { Color = CLAUDE_CONSTANTS.GIT_BRANCH_COLOR } })
      table.insert(elements, { Text = branch })
    end

    -- アクティブなタブのタイトルを更新
    local mux_window = window:mux_window()
    if mux_window then
      local active_tab = mux_window:active_tab()
      if active_tab and active_tab:tab_id() == pane:tab():tab_id() then
        -- タブタイトルを repo_name/branch 形式に設定
        local tab_title = repo_name
        if branch then
          tab_title = repo_name .. '/' .. branch
        end
        active_tab:set_title(tab_title)
      end
    end
  end

  -- Claude ステータス表示（最後に表示）
  if #claude_status.tab_sessions > 0 then
    table.insert(elements, { Text = CLAUDE_CONSTANTS.SPACING_SMALL })
  end
  add_claude_status_to_elements(elements, claude_status.tab_sessions)

  window:set_right_status(wezterm.format(elements))
end)

-- タブタイトルを更新する関数
local function update_tab_titles(window)
  if not window then
    return
  end

  local mux_window = window:mux_window()
  if not mux_window then
    return
  end

  local tabs = mux_window:tabs()
  if not tabs then
    return
  end

  for _, tab in ipairs(tabs) do
    local panes = tab:panes()
    if panes and #panes > 0 then
      local pane = panes[1] -- 最初のペインを使用
      local cwd = pane:get_current_working_dir()

      if cwd then
        local cwd_path = cwd.file_path
        local repo_name = get_git_repo_name(cwd_path)

        if repo_name then
          -- ブランチ名を取得
          local branch = safe_git_command(cwd_path, 'branch', '--show-current')
          if not branch or branch == '' then
            local ref = safe_git_command(cwd_path, 'symbolic-ref', '--short', 'HEAD')
            if ref then
              branch = ref
            else
              branch = safe_git_command(cwd_path, 'rev-parse', '--short', 'HEAD')
            end
          end

          -- タブタイトルを repo_name/branch 形式に設定
          local tab_title = repo_name
          if branch then
            tab_title = repo_name .. '/' .. branch
          end
          tab:set_title(tab_title)
        end
      end
    end
  end
end

-- タブがアクティブになった時にも更新（即座更新）
wezterm.on('tab-active', function(tab, pane, window)
  -- すぐに更新をトリガー
  wezterm.emit('update-right-status', window, pane)

  -- タブタイトルを更新
  update_tab_titles(window)

  -- 少し遅れてもう一度更新（確実性向上）
  wezterm.time.call_after(0.1, function()
    wezterm.emit('update-right-status', window, pane)
    update_tab_titles(window)
  end)
end)

-- ウィンドウフォーカス時にタブタイトルを更新
wezterm.on('window-focus-changed', function(window, pane)
  update_tab_titles(window)
end)

-- 新しいタブ作成時にタブタイトルを更新
wezterm.on('new-tab-button-click', function(window, pane, button, default_action)
  wezterm.time.call_after(0.5, function()
    update_tab_titles(window)
  end)
  return false
end)

-- 自動ウィンドウ分割機能
-- 特定のコマンドを実行した際にウィンドウを自動分割する関数
local function create_auto_split_layout(window, pane)
  -- 現在のペインを基準に分割を実行
  -- まず左右に分割（40:60）
  local right_pane = pane:split {
    direction = 'Right',
    size = 0.6,
  }

  -- 右側のペインを上下に分割（70:30）
  wezterm.sleep_ms(100) -- 分割が完了するまで少し待機
  right_pane:split {
    direction = 'Bottom',
    size = 0.3,
  }
  -- カスタムコマンド実行時の自動分割
  -- シェルで以下のようなエイリアスを設定して使用：
  -- alias mysplit='echo -e "\033]1337;SetUserVar=wezterm_auto_split=MQ==\a"'
  wezterm.on('user-var-changed', function(window, pane, name, value)
    if name == 'wezterm_auto_split' and value == 'MQ==' then -- MQ== は base64 エンコードされた "1"
      create_auto_split_layout(window, pane)
    end
  end)

  -- 元のペイン（左側）にフォーカスを戻す
  pane:activate()
end

config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  -- Window
  { key = 'n', mods = 'SHIFT|CTRL', action = wezterm.action.ToggleFullScreen },
  { key = 'Enter', mods = 'ALT', action = wezterm.action.DisableDefaultAssignment },
  { key = 's', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'v', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'q', mods = 'LEADER', action = wezterm.action.CloseCurrentPane { confirm = true } },
  { key = 'h', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'c', mods = 'LEADER', action = wezterm.action.ActivateCopyMode },
  { key = 'c', mods = 'SHIFT|CTRL', action = wezterm.action { CopyTo = 'Clipboard' } },
  { key = 'u', mods = 'SHIFT|CTRL', action = wezterm.action.ScrollByPage(-0.5) },
  { key = 'd', mods = 'SHIFT|CTRL', action = wezterm.action.ScrollByPage(0.5) },
  { key = 'g', mods = 'SHIFT|CTRL', action = wezterm.action.ScrollToBottom },
  { key = 'Q', mods = 'SHIFT|CTRL', action = wezterm.action.SendString '\x1b[81;6u' },

  -- 自動分割レイアウトを作成するキーバインド
  {
    key = 'w',
    mods = 'LEADER',
    action = wezterm.action_callback(create_auto_split_layout),
  },

  -- Tab
  { key = '{', mods = 'SHIFT|ALT', action = wezterm.action.MoveTabRelative(-1) },
  { key = '}', mods = 'SHIFT|ALT', action = wezterm.action.MoveTabRelative(1) },

  -- Keybinds of Copy and Paste
  { key = 'C', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection' },
  { key = 'V', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },
  { key = 'h', mods = 'CTRL', action = wezterm.action.SendKey { key = 'LeftArrow' } },
  { key = 'j', mods = 'CTRL', action = wezterm.action.SendKey { key = 'DownArrow' } },
  { key = 'k', mods = 'CTRL', action = wezterm.action.SendKey { key = 'UpArrow' } },
  { key = 'l', mods = 'CTRL', action = wezterm.action.SendKey { key = 'RightArrow' } },

  -- Fonts
  { key = '+', mods = 'CTRL|SHIFT', action = 'IncreaseFontSize' },
  { key = '_', mods = 'CTRL|SHIFT', action = 'DecreaseFontSize' },
  { key = 'Backspace', mods = 'CTRL|SHIFT', action = 'ResetFontSize' },

  --
  { key = 'F5', action = 'ReloadConfiguration' },
}

return config
