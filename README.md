# Dotfiles

This is my personal dotfiles repository. It contains the specific dotfiles,
alongside an installation script.

## Installation

To install the dotfiles, run the following commands:

- Linux:

```bash
wget -O - https://raw.githubusercontent.com/andreihh/dotfiles/main/install.sh \
  | bash
```

- MacOS:

```bash
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
curl -Lo \
  https://raw.githubusercontent.com/andreihh/dotfiles/main/opt/run/setup_homebrew.sh \
  | bash
# Follow displayed instructions to finish setting up Homebrew and dependencies.
```

```bash
curl -Lo - https://raw.githubusercontent.com/andreihh/dotfiles/main/install.sh \
  | bash
```

To configure the color scheme for terminal apps, run the `colorscheme` command.

After installing the dotfiles for the first time, you may need to restart your
system to reload the custom environment variables properly.

Optional setup scripts and executables are found under the `opt/` directory.
These are not used by default, you must manually run the setup scripts or link
the executables into the `PATH`.

To configure pre-commit checks, run `pre-commit install` inside the repository.


To add new dotfiles, commit all the changes to bring the repository to a clean
state and run the following command:

```bash
./install.sh -r '' -b ''
```

## XDG directories

The dotfiles follow the XDG specification where possible:

- https://specifications.freedesktop.org/basedir-spec/latest/index.html
- https://wiki.archlinux.org/title/XDG\_Base\_Directory

The XDG environment variables are defined in
`~/.config/profile.d/00-env_xdg.sh`, because some tools don't fall back on
proper defaults and only work if they are explicitly defined.

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
    markdown = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
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
  "kotlin_language_server",
  "isort",
  "pyink",
  "clang-format",
  "google-java-format",
  "ktfmt",
  "prettier",
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
- Toggle tiled left / right: `C-A-,` / `C-A-.`
- Toggle maximized: `C-A-m`
- Toggle fullscreen: `C-A-f`
- Print screen / cancel: `C-A-p` / `Esc`
- Lock screen: `C-A-l`
- Open file explorer: `C-A-e`
- Open web browser: `C-A-w`
- Open shell terminal: `C-A-s`
- Open `tmx` terminal: `C-A-x`
- Open SSH terminal to cloud workstation: `C-A-c`

Terminal:

- Paste: `C-S-v`
- Close terminal: `C-q`
- Switch `tmux` tab: `C-#` (mapped to `M-#`)
- Send interrupt signal: `C-c`

## Licensing

The scripts and configurations are licensed under the MIT license.
