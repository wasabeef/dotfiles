local wezterm = require 'wezterm'

local os = (function()
  if string.find(wezterm.target_triple, 'apple') then
    return "macOS"
  elseif string.find(wezterm.target_triple, 'windows') then
    return "windows"
  end
end)()

local function default_prog()
  if os == "macOS" then
  return {}
  elseif os == "windows" then
    return { 'msys2.cmd', '-defterm', '-no-start', '-full-path', '-shell', 'zsh' }
  end
end

return {
  default_prog = default_prog(),

  font = wezterm.font 'JetBrains Mono',
  font_size = 14.0,

  initial_cols = 180,
  initial_rows = 40,
  window_background_opacity = 1,

  use_fancy_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,

  front_end = "OpenGL",

  leader = {
    key = 'Space',
    mods = 'SHIFT|CTRL',
  },

  keys = {
    -- Window
    { key = 'n', mods = 'SHIFT|CTRL', action = wezterm.action.ToggleFullScreen },
    { key = 's', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'v', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'c', mods = 'SHIFT|CTRL', action = wezterm.action({ CopyTo = 'Clipboard' })},
    { key = 'u', mods = 'SHIFT|CTRL', action = wezterm.action.ScrollByPage(-0.5) },
    { key = 'd', mods = 'SHIFT|CTRL', action = wezterm.action.ScrollByPage(0.5) },
    { key = 'g', mods = 'SHIFT|CTRL', action = wezterm.action.ScrollToBottom },

    -- Keybinds of Copy and Paste
    { key = "C", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
    { key = "V", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },

    -- Fonts
    { key = "+", mods = "CTRL|SHIFT", action = "IncreaseFontSize" },
    { key = "_", mods = "CTRL|SHIFT", action = "DecreaseFontSize" },
    { key = "Backspace", mods = "CTRL|SHIFT", action = "ResetFontSize" },

    --
    { key = "F5", action = "ReloadConfiguration" },
  },
}
