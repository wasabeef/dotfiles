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
  config.font_size = 8
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
config.tab_max_width = 32
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

wezterm.on('format-tab-title', function(tab, tabs, panes, conf, hover, max_width)
  local background = '#282c34'
  local foreground = '#dcd7ba'
  local edge_background = '#282c34'

  if tab.is_active or hover then
    background = '#015db2'
    foreground = '#ffffff'
  end
  local edge_foreground = background

  local title = tab.active_pane.title
  if title == 'nvim' then
    title = ''
  elseif title == 'zsh' then
    title = ''
  elseif title == 'bash' then
    title = '󱆃'
  elseif title == 'sl' then
    title = '󰔬'
  elseif title == 'lazygit' or title == 'tig' then
    title = ''
  elseif title == 'wezterm' then
    title = ''
  elseif title == 'mcfly' then
    title = ''
  elseif title == 'emu' then
    title = '🦤'
  else
    -- title = ''
    title = title
  end

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = ' ' },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Attribute = { Intensity = tab.is_active and 'Bold' or 'Normal' } },
    { Text = ' ' .. (tab.tab_index + 1) .. ': ' .. title .. '  ' },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = '' },
  }
end)

-- 右下に Git ブランチを表示する
config.status_update_interval = 1000

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

wezterm.on('update-right-status', function(window, pane)
  local elements = {}

  local cwd = pane:get_current_working_dir()
  if not cwd then
    window:set_right_status ''
    return
  end

  local cwd_path = cwd.file_path

  -- Git リポジトリかチェック
  if not safe_git_command(cwd_path, 'rev-parse', '--git-dir') then
    window:set_right_status ''
    return
  end

  -- リポジトリ名を取得（優先順位）
  local repo_name = nil

  -- 方法1: remote origin の URL から取得
  local remote_url = safe_git_command(cwd_path, 'config', '--get', 'remote.origin.url')
  if remote_url then
    repo_name = extract_repo_name_from_url(remote_url)
  end

  -- 方法2: 他の remote から取得
  if not repo_name then
    local remotes = safe_git_command(cwd_path, 'remote')
    if remotes and remotes ~= '' then
      -- 最初の remote を使用
      local first_remote = remotes:match '([^\n]+)'
      if first_remote then
        remote_url = safe_git_command(cwd_path, 'config', '--get', 'remote.' .. first_remote .. '.url')
        if remote_url then
          repo_name = extract_repo_name_from_url(remote_url)
        end
      end
    end
  end

  -- 方法3: toplevel のディレクトリ名（通常のリポジトリ）
  if not repo_name then
    local toplevel = safe_git_command(cwd_path, 'rev-parse', '--show-toplevel')
    if toplevel then
      -- worktree の場合、.bare や .git を含む親ディレクトリを探す
      if toplevel:match '%.bare/' or toplevel:match '%.git/' then
        -- パスから bareリポジトリ名を抽出
        repo_name = toplevel:match '([^/]+)%.bare' or toplevel:match '([^/]+)%.git'
      else
        -- 通常のリポジトリ
        repo_name = toplevel:match '([^/]+)$'
      end
    end
  end

  -- 方法4: 現在のディレクトリ名（最終手段）
  if not repo_name then
    local dir_name = cwd_path:match '([^/]+)$'
    -- .git 拡張子を削除
    repo_name = dir_name:gsub('%.git$', '')
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

  -- 表示
  if repo_name then
    table.insert(elements, { Foreground = { Color = '#569CD6' } })
    table.insert(elements, { Text = '  ' })
    table.insert(elements, { Foreground = { Color = '#808080' } })
    table.insert(elements, { Text = repo_name })

    if branch then
      table.insert(elements, { Foreground = { Color = '#4EC9B0' } })
      table.insert(elements, { Text = '   ' })
      table.insert(elements, { Foreground = { Color = '#909090' } })
      table.insert(elements, { Text = branch .. ' ' })
    end
  end

  window:set_right_status(wezterm.format(elements))
end)

-- ベルイベントを捕捉する
config.audible_bell = 'Disabled'
wezterm.on('bell', function(window, pane)
  local proc_info = pane:get_foreground_process_info()
  if not proc_info or not proc_info.argv then
    return
  end
  local cmdline = table.concat(proc_info.argv, ' ')

  if string.find(cmdline, 'claude') then
    -- Claude タスクが完了したときの処理
    local sound_file = wezterm.home_dir .. '/.claude/perfect.mp3'
    if os == 'macOS' then
      wezterm.background_child_process { 'afplay', sound_file }
    elseif os == 'linux' then
      wezterm.background_child_process { 'aplay', sound_file }
    end
    -- ウィンドウに通知を表示
    local process_name = proc_info.name or 'プロセス'
    window:toast_notification('Claude タスク完了', process_name .. ' が完了しました', nil, 3000)
  else
    -- その他のプロセスのベルイベント
    -- config.audible_bell = 'Disabled' にしているので、ここで音を鳴らす
    if os == 'macOS' then
      -- macOS の場合、デフォルトのサウンドを鳴らす
      wezterm.background_child_process { 'afplay', '/System/Library/Sounds/Tink.aiff' }
    elseif os == 'linux' then
      wezterm.background_child_process { 'aplay', '/usr/share/sounds/freedesktop/stereo/bell.oga' }
    end
    return
  end
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
