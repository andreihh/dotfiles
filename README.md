# Dotfiles

This is my personal dotfiles repository. It contains the specific dotfiles,
alongside an installation script.

## Installation

To install the dotfiles:

- Install Homebrew on MacOS (see https://brew.sh/):

```bash
HOMEBREW_INSTALLER="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
/bin/bash -c "$(curl -fsSL "${HOMEBREW_INSTALLER}")"
exec bash  # Reload shell environment to add Homebrew to `PATH`
```

- Download and run the installer using one of the following commands:

```bash
wget -O - https://codeberg.org/andreihh/dotfiles/raw/branch/main/install.sh \
  | bash
```

```bash
curl -Lo - https://codeberg.org/andreihh/dotfiles/raw/branch/main/install.sh \
  | bash
```

- Run the `theme` command to configure the system theme.
- Log out and back in to ensure the environment is loaded properly.
- Run `pre-commit install` inside the repository to configure pre-commit checks.

To update the dotfiles, run `install.sh -u` from the repository in a clean
state.

## XDG directories

The dotfiles follow the XDG specification where possible:

- https://specifications.freedesktop.org/basedir-spec/latest/index.html
- https://wiki.archlinux.org/title/XDG_Base_Directory

If not already set, the XDG environment variables are exported with default
values in `${HOME}/.config/profile.d/00-env_xdg.sh` because some tools don't
fall back on proper defaults and only work if they are explicitly defined.

## Private configs

User or device specific configs and binaries that should not be included in the
repository can be provided in:

- `${HOME}/.local/bin/`
- `${XDG_CONFIG_HOME:-${HOME}/.config}/profile.d/`
- `${XDG_CONFIG_HOME:-${HOME}/.config}/bash.d/`
- `${XDG_CONFIG_HOME:-${HOME}/.config}/nvim/lua/config/overrides.lua`
- `${XDG_CONFIG_HOME:-${HOME}/.config}/nvim/lua/plugins/`
- `${XDG_CONFIG_HOME:-${HOME}/.config}/nvim/[after/]lsp/`
- `${XDG_CONFIG_HOME:-${HOME}/.config}/vim/overrides.vim`
- `${XDG_CONFIG_HOME:-${HOME}/.config}/vim/overrides.plug.vim`

Example `${XDG_CONFIG_HOME:-${HOME}/.config}/bash.d/10-extras.sh`:

```bash
# extras.sh: exports device-specific settings.

# Export Git credentials.
export GIT_AUTHOR_NAME="Andrei Heidelbacher"
export GIT_COMMITTER_NAME="${GIT_AUTHOR_NAME}"
...
```

Example `${XDG_CONFIG_HOME:-${HOME}/.config}/nvim/lua/config/overrides.lua`:

```lua
-- [[ Config overrides ]]

-- Ensure development tools are installed by Mason.
--
-- Installs `tree-sitter-cli` automatically. Run `:TSInstall stable unstable`
-- afterwards to install Treesitter parsers.
vim.g.ensure_installed = {
  -- General formatting
  "prettier",
  -- Lua
  "lua-language-server",
  "stylua",
  -- Vimscript
  "vim-language-server",
  -- Bash
  "bash-language-server",
  "shfmt",
  "shellcheck", -- integrates with `bash-language-server`
  -- Python
  "pyright",
  "isort",
  "black",
  "pylint",
  -- C/C++
  "clangd",
  "clang-format",
  -- Java
  "jdtls",
  "google-java-format",
  "checkstyle",
}

-- Start LSPs automatically.
--  Override configs with `vim.lsp.config()`.
--  See `:help vim.lsp.Config`
vim.lsp.enable({
  "lua_ls",
  "vimls",
  "bashls",
  "pyright",
  "clangd",
  "jdtls",
})

-- Configure formatters.
--  See `:help conform`
vim.g.format_opts = {
  formatters_by_ft = {
    markdown = { "prettier" },
    yaml = { "prettier" },
    json = { "prettier" },
    lua = { "stylua" },
    sh = { "shfmt" },
    python = { "isort", "black" },
    cpp = { "clang-format" },
    java = { "google-java-format" },
  },
}

-- Configure linters.
--  See `:help lint`
vim.g.lint_opts = {
  linters_by_ft = {
    python = { "pylint" },
    -- `clangd` embeds `clang-tidy`
    java = { "checkstyle" },
  },
}
```

## Hotkeys

Keyboard layout changes:

- Swap `Caps Lock` with `Esc`
- Linux modifiers: `Super Alt Ctrl Space Alt Ctrl`
- MacOS modifiers: `Ctrl Opt Cmd Space Opt Cmd`

Common shortcuts (`C = Ctrl / Cmd`, `A = Alt / Opt`, `S = Shift`):

- New tab: `C-t`
- Close window / tab: `C-w`
- Quit app: `C-q`
- Cycle web browser tabs: `C-{12}`
- Cycle windows: `C-[S]-Tab`
- Switch to workspace: `A-{1-9}`
- Move window to workspace: `C-A-{1-9}`
- Toggle window tiled left / right: `C-A-{hl}`
- Toggle window maximized / fullscreen: `A-[S]-z`
- Print screen / cancel: `A-p` / `Esc`
- Record screen / cancel: `A-r` / `Esc`
- Toggle mute volume / microphone: `A-[S]-Backspace`
- Adjust volume: `A-{-=}`
- Adjust screen brightness: `A-S-{-=}`
- Focus notification / dismiss: `A-n` / `Esc`
- Open notification center: `A-S-n`
- Open settings: `A-S-s`
- Open file explorer: `A-e`
- Open web browser: `A-w`
- Open terminal: `A-x`
- Open `tmx` terminal: `A-S-x`
- Open SSH terminal to cloud workstation: `A-c`
- Open app launcher: `A-a`
- Lock screen: `A-Esc`
- Log out: `A-S-Esc`

Terminal:

- Send `SIGINT`: `C-c`
- Paste: `C-S-v`
- Close terminal: `C-q`
- Switch `tmux` tab: `C-{1-9}` (mapped to `A-{1-9}`)
- Resize `tmux` / `nvim` / `vim` windows: `C-S-{hjkl=}` (mapped to `A-{hjkl=}`)

## Licensing

The scripts and configurations are licensed under the MIT license.
