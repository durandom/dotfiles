# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository based on thoughtbot's dotfiles framework, containing configuration files for various development tools and shell environments. The repository uses `rcm` (rc file management) to manage symlinks between the repository and the home directory.

## Key Architecture & Structure

- **rcm-based**: Uses `rcup` to create symlinks from this repository to the home directory
- **Modular zsh configuration**: Configuration split across multiple files in `zsh/` with `pre/` and `post/` subdirectories for load order control
- **Local overrides**: Supports `.local` files for personal customizations that won't be committed
- **Plugin management**: 
  - Vim: Uses vim-plug for plugin management
  - Zsh: Uses sheldon for plugin management (configured in `config/sheldon/plugins.toml`)
- **Git hooks**: Custom git hooks in `git_template/hooks/` that are automatically installed

## Common Commands

### Dotfiles Management
- `rcup` - Update/install dotfiles symlinks after changes
- `env RCRC=$HOME/dotfiles/rcrc rcup` - Initial installation with proper configuration

### Development Workflow
The repository includes several custom aliases and functions:
- `g` - Git status (no args) or git command wrapper (with args)
- `b` - Bundle command wrapper
- `v` - Opens file in $VISUAL editor

### Post-installation
After cloning or updating:
1. Run `rcup` to update symlinks
2. The `hooks/post-up` script will automatically:
   - Install vim plugins via vim-plug
   - Clone tmux plugin manager if not present

## Important Configuration Files

- `zshrc` - Main zsh configuration that sources other files
- `config/sheldon/plugins.toml` - Zsh plugin configuration
- `config/starship.toml` - Starship prompt configuration
- `wezterm.lua` - WezTerm terminal configuration
- `config/aichat/config.yaml` - AI chat tool configuration
- `vimrc` and `vimrc.bundles` - Vim configuration and plugin definitions

## Configuration Patterns

When modifying configurations:
1. Global settings go in the main files (e.g., `zshrc`, `vimrc`)
2. Machine-specific settings should use `.local` variants
3. Zsh configurations can be modular - place files in:
   - `zsh/configs/pre/` - Loaded first
   - `zsh/configs/` - Normal load order
   - `zsh/configs/post/` - Loaded last