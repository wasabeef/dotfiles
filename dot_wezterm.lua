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
  bottom = '0.5cell',
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
  config.font_size = 10.0
  config.initial_cols = 320
  config.initial_rows = 100

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
  elseif title == 'wezterm' then
    title = ''
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

config.leader = { key = 'Space', mods = 'SHIFT|CTRL' }
config.keys = {
  -- Window
  { key = 'n', mods = 'SHIFT|CTRL', action = wezterm.action.ToggleFullScreen },
  { key = 'Enter', mods = 'ALT', action = wezterm.action.DisableDefaultAssignment },
  { key = 's', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'v', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'c', mods = 'SHIFT|CTRL', action = wezterm.action { CopyTo = 'Clipboard' } },
  { key = 'u', mods = 'SHIFT|CTRL', action = wezterm.action.ScrollByPage(-0.5) },
  { key = 'd', mods = 'SHIFT|CTRL', action = wezterm.action.ScrollByPage(0.5) },
  { key = 'g', mods = 'SHIFT|CTRL', action = wezterm.action.ScrollToBottom },

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
