# Dotfiles

This is my personal dotfiles repository. It contains the specific dotfiles,
alongside an installation script.

## Installation

To install the dotfiles:

- Install required dependencies:

  - Debian / Ubuntu: `sudo apt install -y curl`
  - Fedora: `sudo dnf install curl`
  - MacOS:

```bash
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export HOMEBREW_SHELLENV="${XDG_CONFIG_HOME:?}/profile.d/00-brew.sh"
export HOMEBREW_INSTALLER="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
/bin/bash -c "$(curl -fsSL "${HOMEBREW_INSTALLER}")"
# Follow displayed instructions to finish setting up Homebrew.
```

- Download and run the installer:

```bash
curl -Lo - https://codeberg.org/andreihh/dotfiles/raw/branch/main/install.sh \
  | bash
```

- Reboot your system to ensure the environment variables are loaded properly.
- Run the `update-system` command to configure settings and install packages.
- Run the `colorscheme` command to configure the color scheme for terminal apps.
- Run `pre-commit install` inside the repository to configure pre-commit checks.

To update the dotfiles, run `install.sh` from the repository in a clean state.

## XDG directories

The dotfiles follow the XDG specification where possible:

- https://specifications.freedesktop.org/basedir-spec/latest/index.html
- https://wiki.archlinux.org/title/XDG\_Base\_Directory

The XDG environment variables are defined in
`~/.config/profile.d/00-env_xdg.sh`, because some tools don't fall back on
proper defaults and only work if they are explicitly defined. They can be
overridden in `~/.env`.

## Private configs

User or device specific configs and binaries that should not be included in the
repository can be provided in:

- `~/.env`
- `~/.config/profile.d/`
- `~/.config/bash.d/`
- `~/.local/bin/`
- `~/.config/tmux/overrides.tmux`
- `~/.config/nvim/lua/config/overrides.lua`
- `~/.config/nvim/lua/plugins/`
- `~/.config/nvim/lsp/`
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

-- Start LSPs automatically.
--  Override configs with `vim.lsp.config()`.
--  See `:help vim.lsp.Config`
vim.lsp.enable({ "pyright", "clangd", "jdtls" })

-- Configure formatters.
--  See `:help conform`
vim.g.format_opts = {
  formatters_by_ft = {
    python = { "isort", "pyink" },
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

-- Ensure development tools are installed by Mason.
vim.g.ensure_installed = {
  "pyright",
  "clangd",
  "jdtls",
  "isort",
  "pyink",
  "clang-format",
  "google-java-format",
  "pylint",
  "checkstyle",
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
- Cycle windows: `C-[S]-tab`
- Zoom in / out: `C-=` / `C--`
- Toggle fullscreen: `C-A-f`
- Toggle maximized: `C-A-m`
- Toggle tiled left / right: `C-A-,` / `C-A-.`
- Print screen / cancel: `C-A-p` / `Esc`
- Lock screen: `C-A-l`
- Open file explorer: `C-A-e`
- Open web browser: `C-A-w`
- Open shell terminal: `C-A-s`
- Open `tmx` terminal: `C-A-x`
- Open SSH terminal to cloud workstation: `C-A-c`

Terminal:

- Send `SIGINT`: `C-c`
- Paste: `C-S-v`
- Close terminal: `C-q`
- Switch `tmux` tab: `C-#` (mapped to `M-#`)

## Licensing

The scripts and configurations are licensed under the MIT license.
