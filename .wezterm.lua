local wezterm = require 'wezterm'
return {

  font = wezterm.font 'JetBrains Mono',
  font_size = 14.0,

  initial_cols = 180,
  initial_rows = 40,
  window_background_opacity = 1,

  use_fancy_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,

  ront_end = "OpenGL",

  leader = {
    key = 'Space',
    mods = 'SHIFT|CTRL',
  },

  keys = {
    {
      key = 'n',
      mods = 'SHIFT|CTRL',
      action = wezterm.action.ToggleFullScreen,
    },
    {
      key = 'v',
      mods = 'SHIFT|CTRL',
      action = wezterm.action.Paste
    },
    { key = 'u', mods = 'SHIFT|CTRL', action = wezterm.action.ScrollByPage(-0.5) },
    { key = 'd', mods = 'SHIFT|CTRL', action = wezterm.action.ScrollByPage(0.5) },
    { key = 'g', mods = 'SHIFT|CTRL', action = wezterm.action.ScrollToBottom },
    { key = 's', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'v', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  },
}
