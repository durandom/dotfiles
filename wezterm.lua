-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Bell notification handler for macOS
wezterm.on('bell', function(window, pane)
  -- Get the current foreground process info
  local process_info = pane:get_foreground_process_info()
  local process_name = pane:get_foreground_process_name()

  -- Try to get process arguments to detect claude
  local is_claude = false
  if process_info and process_info.argv then
    for _, arg in ipairs(process_info.argv) do
      if arg:match("claude") then
        is_claude = true
        break
      end
    end
  end

  -- Also check pane title as a fallback
  local pane_title = pane:get_title()
  if pane_title:match("claude") then
    is_claude = true
  end

  -- Check if audible bell should be enabled for this process
  local enable_audible_for = {
    ["cloud"] = true,
    -- Add more commands here as needed
  }

  -- Extract just the command name from the full path
  local cmd = process_name:match("([^/]+)$") or process_name

  if enable_audible_for[cmd] or is_claude then
    wezterm.log_info("Audible bell for: " .. (is_claude and "claude" or cmd))
    -- For specific commands, play sound
    wezterm.background_child_process({
      'osascript',
      '-e',
      'display notification "Bell triggered in WezTerm" with title "WezTerm Alert" sound name "Glass"'
    })
  else
    wezterm.log_info("Visual bell for: " .. cmd)
  end
  -- Visual bell will still trigger for all commands via the config below
end)

-- This is where you actually apply your config choices
config.font = wezterm.font 'DankMono Nerd Font'
config.font_size = 14

config.scrollback_lines = 35000
config.enable_scroll_bar = true

-- Set up leader/prefix key (like tmux)
config.leader = { key = 's', mods = 'CTRL', timeout_milliseconds = 1000 }

-- Add key bindings for Option+Left/Right for word navigation
config.keys = {
  -- Option+Left: move backward one word (macOS standard)
  {
    key = 'LeftArrow',
    mods = 'OPT',
    action = wezterm.action.SendString('\x1b\x62'), -- ESC+b
  },
  -- Option+Right: move forward one word (macOS standard)
  {
    key = 'RightArrow',
    mods = 'OPT',
    action = wezterm.action.SendString('\x1b\x66'), -- ESC+f
  },
  {
    key = '>',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
    --   initial_value = 'My Tab Name',
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  -- Disable Option+Enter fullscreen to allow Claude CLI to use it
  {
    key = 'Enter',
    mods = 'OPT',
    action = wezterm.action.SendString('\x1b\x0d'), -- ESC+Enter
  },

  -- Leader/Prefix key bindings (tmux-style)
  -- Send Ctrl+S when pressing leader twice
  {
    key = 's',
    mods = 'LEADER|CTRL',
    action = act.SendKey { key = 's', mods = 'CTRL' },
  },

  -- Pane splitting
  -- Split horizontal (top/bottom) - like tmux's Ctrl-b "
  {
    key = '"',
    mods = 'LEADER|SHIFT',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- Split vertical (left/right) - like tmux's Ctrl-b %
  {
    key = '%',
    mods = 'LEADER|SHIFT',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },

  -- Alternative easier splits (no shift required)
  {
    key = '-',
    mods = 'LEADER',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = '\\',
    mods = 'LEADER',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },

  -- Pane navigation with leader + arrow keys
  {
    key = 'LeftArrow',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'UpArrow',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Down',
  },

  -- Pane navigation with vim-style keys
  {
    key = 'h',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Down',
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Right',
  },

  -- Close current pane
  {
    key = 'x',
    mods = 'LEADER',
    action = act.CloseCurrentPane { confirm = true },
  },

  -- Toggle pane zoom state
  {
    key = 'z',
    mods = 'LEADER',
    action = act.TogglePaneZoomState,
  },

  -- Create new tab
  {
    key = 'c',
    mods = 'LEADER',
    action = act.SpawnTab 'CurrentPaneDomain',
  },

  -- Navigate tabs
  {
    key = 'n',
    mods = 'LEADER',
    action = act.ActivateTabRelative(1),
  },
  {
    key = 'p',
    mods = 'LEADER',
    action = act.ActivateTabRelative(-1),
  },

  -- Navigate to tab by number
  {
    key = '1',
    mods = 'LEADER',
    action = act.ActivateTab(0),
  },
  {
    key = '2',
    mods = 'LEADER',
    action = act.ActivateTab(1),
  },
  {
    key = '3',
    mods = 'LEADER',
    action = act.ActivateTab(2),
  },
  {
    key = '4',
    mods = 'LEADER',
    action = act.ActivateTab(3),
  },
  {
    key = '5',
    mods = 'LEADER',
    action = act.ActivateTab(4),
  },
}

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

-- Bell configuration
config.audible_bell = "Disabled"  -- Disable system beep since we're using notifications
config.visual_bell = {
  fade_in_duration_ms = 75,
  fade_out_duration_ms = 75,
  -- target = 'CursorColor',  -- Flash the cursor instead of background
}

-- and finally, return the configuration to wezterm
return config
