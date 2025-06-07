# Dotfiles

This is my personal dotfiles repository. It contains the specific dotfiles,
alongside an installation script.

## Installation

To install the dotfiles:

- Install required dependencies:

  - MacOS:

```bash
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export HOMEBREW_SHELLENV="${XDG_CONFIG_HOME:?}/profile.d/00-brew.sh"
export HOMEBREW_INSTALLER="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
/bin/bash -c "$(curl -fsSL "${HOMEBREW_INSTALLER}")"

# Follow displayed instructions to finish setting up Homebrew.

brew install wget
```

- Download and run the installer:

```bash
wget -O - https://codeberg.org/andreihh/dotfiles/raw/branch/main/install.sh \
  | bash
```

- Reboot your system to ensure the environment variables are loaded properly.
- Run the `theme` command to configure the system theme.
- Run `pre-commit install` inside the repository to configure pre-commit checks.

To update the dotfiles, run `install.sh -u` from the repository in a clean
state.

## XDG directories

The dotfiles follow the XDG specification where possible:

- https://specifications.freedesktop.org/basedir-spec/latest/index.html
- https://wiki.archlinux.org/title/XDG_Base_Directory

The XDG environment variables are defined in `~/.config/profile.d/00-env_xdg.sh`
because some tools don't fall back on proper defaults and only work if they are
explicitly defined.

## Private configs

User or device specific configs and binaries that should not be included in the
repository can be provided in:

- `~/.config/profile.d/`
- `~/.config/bash.d/`
- `~/.local/bin/`
- `~/.config/nvim/lua/config/overrides.lua`
- `~/.config/nvim/lua/plugins/`
- `~/.config/nvim/[after/]lsp/`
- `~/.config/vim/overrides.vim`
- `~/.config/vim/overrides.plug.vim`

Example `~/.config/bash.d/10-extras.sh`:

```bash
# extras.sh: exports device-specific settings.

# Export Git credentials.
export GIT_AUTHOR_NAME="Andrei Heidelbacher"
export GIT_COMMITTER_NAME="${GIT_AUTHOR_NAME}"
...
```

Example `~/.config/nvim/lua/config/overrides.lua`:

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
- Cycle web browser tabs: `C-1` / `C-2`
- Cycle windows: `C-[S]-Tab`
- Switch to workspace: `A-{1-9}`
- Move window to workspace: `A-S-{1-9}`
- Toggle window maximized / fullscreen: `C-S-m` / `C-S-z`
- Toggle window tiled left / right: `C-S-h` / `C-S-l`
- Focus notification / dismiss: `A-n` / `Esc`
- Print screen / cancel: `A-p` / `Esc`
- Record screen / cancel: `A-r` / `Esc`
- Lock screen: `A-Esc`
- Open app launcher: `A-a`
- Open file explorer: `A-e`
- Open web browser: `A-w`
- Open shell terminal: `A-s`
- Open `tmx` terminal: `A-x`
- Open SSH terminal to cloud workstation: `A-c`

Terminal:

- Send `SIGINT`: `C-c`
- Paste: `C-S-v`
- Close terminal: `C-q`
- Switch `tmux` tab: `C-{1-9}` (mapped to `M-{1-9}`)

## Licensing

The scripts and configurations are licensed under the MIT license.
