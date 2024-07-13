local wezterm = require("wezterm")

local os = (function()
  if string.find(wezterm.target_triple, "apple") then
    return "macOS"
  elseif string.find(wezterm.target_triple, "windows") then
    return "windows"
  elseif string.find(wezterm.target_triple, "linux") then
    return "linux"
  end
end)()

-- Common settings
local config = {

  -- cyberdream.nvim
  colors = {
    foreground = "#ffffff",
    background = "#16181a",

    cursor_bg = "#ffffff",
    cursor_fg = "#16181a",
    cursor_border = "#ffffff",

    selection_fg = "#ffffff",
    selection_bg = "#3c4048",

    scrollbar_thumb = "#16181a",
    split = "#16181a",

    ansi = { "#16181a", "#ff6e5e", "#5eff6c", "#f1ff5e", "#5ea1ff", "#bd5eff", "#5ef1ff", "#ffffff" },
    brights = { "#3c4048", "#ff6e5e", "#5eff6c", "#f1ff5e", "#5ea1ff", "#bd5eff", "#5ef1ff", "#ffffff" },
    indexed = { [16] = "#ffbd5e", [17] = "#ff6e5e" },
  },

  font = wezterm.font_with_fallback({
    "Cascadia Code",
    "JetBrains Mono",
  }),
  window_background_opacity = 1,
  window_padding = { left = 0, right = 0, top = 0, bottom = 0 },

  use_fancy_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,

  front_end = "OpenGL",

  leader = { key = "Space", mods = "SHIFT|CTRL" },

  keys = {
    -- Window
    { key = "n", mods = "SHIFT|CTRL", action = wezterm.action.ToggleFullScreen },
    { key = "Enter", mods = "ALT", action = wezterm.action.DisableDefaultAssignment },
    { key = "s", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "v", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "c", mods = "SHIFT|CTRL", action = wezterm.action({ CopyTo = "Clipboard" }) },
    { key = "u", mods = "SHIFT|CTRL", action = wezterm.action.ScrollByPage(-0.5) },
    { key = "d", mods = "SHIFT|CTRL", action = wezterm.action.ScrollByPage(0.5) },
    { key = "g", mods = "SHIFT|CTRL", action = wezterm.action.ScrollToBottom },

    -- Tab
    { key = "{", mods = "SHIFT|ALT", action = wezterm.action.MoveTabRelative(-1) },
    { key = "}", mods = "SHIFT|ALT", action = wezterm.action.MoveTabRelative(1) },

    -- Keybinds of Copy and Paste
    { key = "C", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
    { key = "V", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
    { key = "h", mods = "CTRL", action = wezterm.action.SendKey({ key = "LeftArrow" }) },
    { key = "j", mods = "CTRL", action = wezterm.action.SendKey({ key = "DownArrow" }) },
    { key = "k", mods = "CTRL", action = wezterm.action.SendKey({ key = "UpArrow" }) },
    { key = "l", mods = "CTRL", action = wezterm.action.SendKey({ key = "RightArrow" }) },

    -- Fonts
    { key = "+", mods = "CTRL|SHIFT", action = "IncreaseFontSize" },
    { key = "_", mods = "CTRL|SHIFT", action = "DecreaseFontSize" },
    { key = "Backspace", mods = "CTRL|SHIFT", action = "ResetFontSize" },

    --
    { key = "F5", action = "ReloadConfiguration" },
  },
}

-- macOS settings
if os == "macOS" then
  config["font_size"] = 11.0
  config["initial_cols"] = 320
  config["initial_rows"] = 100

-- Windows settings
elseif os == "windows" then
  -- config["default_prog"] = { 'msys2.cmd', '-defterm', '-no-start', '-full-path', '-shell', 'zsh' }
  config["font_size"] = 12.0
  config["initial_cols"] = 140
  config["initial_rows"] = 60

-- Linux settings
elseif os == "linux" then
end

return config
