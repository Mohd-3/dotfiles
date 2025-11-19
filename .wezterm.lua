local wezterm = require('wezterm')
local config = wezterm.config_builder()
config.use_fancy_tab_bar = true
config.color_scheme = 'nord'
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.disable_default_key_bindings = true

config.keys = {
    {
        key = 'L',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ShowDebugOverlay,
    },
    {
        key = 'c',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.CopyTo('Clipboard'),
    },
    {
        key = 'v',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.PasteFrom('Clipboard'),
    },
    {
        key = 'F11',
        action = wezterm.action.ToggleFullScreen,
    },
    {
        key = '=',
        mods = 'CTRL',
        action = wezterm.action.IncreaseFontSize,
    },
    {
        key = 't',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SpawnTab('CurrentPaneDomain'),
    },
    {
        key = 'n',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SpawnWindow,
    },
    {
        key = '0',
        mods = 'CTRL',
        action = wezterm.action.ResetFontSize,
    },

    {
        key = '-',
        mods = 'CTRL',
        action = wezterm.action.DecreaseFontSize,
    },
    {
        key = '1',
        mods = 'ALT',
        action = wezterm.action.ActivateTab(0),
    },
    {
        key = '2',
        mods = 'ALT',
        action = wezterm.action.ActivateTab(1),
    },
    {
        key = '3',
        mods = 'ALT',
        action = wezterm.action.ActivateTab(2),
    },
    {
        key = '4',
        mods = 'ALT',
        action = wezterm.action.ActivateTab(3),
    },
    {
        key = '5',
        mods = 'ALT',
        action = wezterm.action.ActivateTab(4),
    },
    {
        key = '6',
        mods = 'ALT',
        action = wezterm.action.ActivateTab(5),
    },
    {
        key = '7',
        mods = 'ALT',
        action = wezterm.action.ActivateTab(6),
    },
    {
        key = '8',
        mods = 'ALT',
        action = wezterm.action.ActivateTab(7),
    },
    {
        key = '9',
        mods = 'ALT',
        action = wezterm.action.ActivateTab(8),
    },
    {
        key = '0',
        mods = 'ALT',
        action = wezterm.action.ActivateTab(9),
    },
    {
        key = '[',
        mods = 'CTRL',
        action = wezterm.action.ActivateTabRelative(-1),
    },
    {
        key = ']',
        mods = 'CTRL',
        action = wezterm.action.ActivateTabRelative(1),
    },
}
config.font = wezterm.font('Hack Nerd Font')
config.default_cursor_style = 'SteadyBar'
return config
