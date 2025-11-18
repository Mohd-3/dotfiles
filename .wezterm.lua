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
config.keys = {
    {
        key = 'n',
        mods = 'SHIFT|CTRL',
        action = wezterm.action.ToggleFullScreen,
    },
}
config.font = wezterm.font('Hack Nerd Font')
config.default_cursor_style = 'SteadyBar'
return config
