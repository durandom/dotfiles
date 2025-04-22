-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.font = wezterm.font 'DankMono Nerd Font'
config.font_size = 14

config.scrollback_lines = 35000
config.enable_scroll_bar = true

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
function get_appearance()
    if wezterm.gui then
        return wezterm.gui.get_appearance()
    end
    return 'Dark'
end

-- Lua lookup table for popular color schemes with dark and light variants.
-- The exact names used as values might need adjustment depending on the specific
-- terminal emulator, VS Code theme identifier, or Neovim plugin being used.

local schemes = {
    github = {
        dark = "Github Dark (Gogh)", -- Common name in VS Code. Config name might be 'github_dark'.
        light = "Github Light (Gogh)" -- Common name in VS Code. Config name might be 'github_light'.
        -- Notes: Also includes Dimmed, High Contrast, and Colorblind variants.
    },
    ayu = {
        dark = "Ayu Dark (Gogh)", -- Common name. Config name might be 'ayu' or 'ayu_dark'.
        light = "Ayu Light (Gogh)" -- Common name. Config name might be 'ayu_light'.
        -- Notes: 'Ayu Mirage' is another dark variant.
    },
    tokyo_night = { -- Corrected spelling from 'tokyou'
        dark = "Tokyo Night (Gogh)", -- Common name. Config name often 'tokyonight'.
        light = "Tokyo Night Light (Gogh)" -- Common name. Config name often 'tokyonight_light'.
        -- Notes: 'Tokyo Night Storm' ('tokyonight_storm') is another dark variant.
    },
    gruvbox = {
        dark = "Gruvbox Dark (Gogh)",
        light = "Gruvbox (Gogh)"
        -- Notes: For many terminal/vim ports, the theme name is just 'gruvbox'.
        -- The light/dark mode is activated by setting the background option,
        -- e.g., in Neovim: `vim.o.background = 'dark'` or `vim.o.background = 'light'`.
        -- Check the specific port's documentation.
    },
    solarized = {
        dark = "solarized",
        light = "solarized"
        -- Notes: Similar to gruvbox, often uses `vim.o.background = 'dark'` or `'light'`.
        -- Some ports might use specific names like 'solarized-dark'/'solarized-light'
        -- or require configuration options within the theme setup. Check documentation.
    },
    night_owl = {
        dark = "Night Owl (Gogh)", -- Common name. Config name often 'night_owl'.
        light = "Night Owlish Light" -- Common name. Config name often 'light_owl'.
    },
    bluloco = {
        dark = "BlulocoDark", -- Common name. Config name might be 'bluloco_dark'.
        light = "BlulocoLight" -- Common name. Config name might be 'bluloco_light'.
    }
}

function scheme_for_appearance(appearance)
    local scheme = 'bluloco'
    if appearance:find 'Dark' then
        return schemes[scheme].dark
    else
        return schemes[scheme].light
    end
end

config.color_scheme = scheme_for_appearance(get_appearance())

-- config.window_frame = {
--     -- The font used in the tab bar.
--     -- Roboto Bold is the default; this font is bundled
--     -- with wezterm.
--     -- Whatever font is selected here, it will have the
--     -- main font setting appended to it to pick up any
--     -- fallback fonts you may have used there.
--     font = wezterm.font {
--         family = 'DankMono Nerd Font',
--         weight = 'Bold'
--     },

--     -- The size of the font in the tab bar.
--     -- Default to 10.0 on Windows but 12.0 on other systems
--     font_size = 14.0,

--     -- The overall background color of the tab bar when
--     -- the window is focused
--     -- use the background color of the theme
--     active_titlebar_bg = '#333333',

--     -- The overall background color of the tab bar when
--     -- the window is not focused
--     inactive_titlebar_bg = '#333333'
-- }

-- tab bar settings
-- It is important that the apply_to_config-function is called after color_scheme has been set.
-- config.tab_bar_at_bottom = true
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config,
{
    modules = {
        cwd = {
            enabled = true
        },
        zoom = {
            enabled = true
        },
    }
})

config.colors.tab_bar.new_tab = {
    bg_color = config.colors.tab_bar.active_tab.bg_color,
    fg_color = config.colors.tab_bar.active_tab.fg_color,
}

-- and finally, return the configuration to wezterm
return config
