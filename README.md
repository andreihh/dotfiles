# Dotfiles

This is my personal dotfiles repository. It contains the specific dotfiles,
alongside an installation script.

## Installation

To install the dotfiles, run one of the following commands:

```bash
curl -Lo - https://raw.githubusercontent.com/andreihh/dotfiles/main/installer/install.sh \
  | bash
```

```bash
wget -O - https://raw.githubusercontent.com/andreihh/dotfiles/main/installer/install.sh \
  | bash
```

After installing the dotfiles for the first time, you may need to restart your
system to reload the custom environment variables properly.

To add new dotfiles, commit all the changes to bring the repository to a clean
state and run the following command:

```bash
"${XDG_CONFIG_HOME}/dotfiles/installer/install_dotfiles.sh"
```

## XDG directories

The dotfiles follow the XDG specification where possible:
- https://specifications.freedesktop.org/basedir-spec/latest/index.html
- https://wiki.archlinux.org/title/XDG\_Base\_Directory

Some tools only work if the XDG environment variables are explicitly defined. By
default, they are defined in `~/.config/profile.d/00-env_xdg.sh`.

## Private configs

User or device specific configs and binaries that should not be included in the
repository can be provided in:

- `~/.config/profile.d/`
- `~/.config/bash.d/`
- `~/.local/bin/`
- `~/.config/vim/overrides.vim`
- `~/.config/vim/overrides.plug.vim`
- `~/.config/nvim/lua/config/overrides.lua`
- `~/.config/nvim/lua/plugins/`

Example `~/.config/bash.d/10-extras.sh`:

```bash
# extras.sh: exports device-specific settings.

# Export Git credentials.
export GIT_AUTHOR_NAME="Andrei Heidelbacher"
export GIT_COMMITTER_NAME="${GIT_AUTHOR_NAME}"
export GIT_AUTHOR_EMAIL="andrei.heidelbacher@gmail.com"
export GIT_COMMITTER_EMAIL="${GIT_AUTHOR_EMAIL}"

...
```

Example `~/.config/nvim/lua/config/overrides.lua`:

```lua
-- [[ Config overrides ]]

local ensure_installed = vim.g.lsp_opts.ensure_installed or {}
vim.list_extend(ensure_installed, {
    "pyright",
    "clangd",
    "jdtls",
    "kotlin_language_server",
    "pyink",
    "clang-format",
    "google-java-format",
    "ktfmt",
    "prettier",
    "pylint",
    -- `clangd` embeds `clang-tidy`
    "checkstyle",
})

vim.g.lsp_opts = vim.tbl_deep_extend("force", vim.g.lsp_opts, {
  servers = {
    pyright = {},
    clangd = {},
    jdtls = {},
    kotlin_language_server = {},
  },
  formatters_by_ft = {
    python = { "pyink" },
    cpp = { "clang-format" },
    java = { "google-java-format" },
    kotlin = { "ktfmt" },
    markdown = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
  },
  formatters = {
    ktfmt = { prepend_args = { "--google-style" } },
  },
  linters_by_ft = {
    python = { "pylint" },
    -- `clangd` embeds `clang-tidy`
    java = { "checkstyle" },
  },
  ensure_installed = ensure_installed,
})
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
- Cycle windows: `C-[S]-tab` (requires https://alt-tab-macos.netlify.app/)
- Zoom in / out: `C-=` / `C--`
- Toggle tiled left / right: `C-A-,` / `C-A-.`
- Toggle maximized: `C-A-m`
- Toggle fullscreen: `C-A-f`
- Print screen / cancel: `C-A-p` / `Esc`
- Lock screen: `C-A-l`
- Open file explorer: `C-A-e`
- Open web browser: `C-A-w`
- Open shell terminal: `C-A-s`
- Open `tmux` terminal in the `work` session: `C-A-x`

Terminal settings:
- Paste: `C-p`
- Open clipboard selection with external system handler: `A-o`
- Close window: `C-q`
- Send interrupt signal: `C-c`
- Switch `tmux` tab: `C-1` / ... / `C-9`
- Swap `Cmd` with `Ctrl` in `iTerm2`
- Do not remap modifiers `Cmd-[S]-Tab`, `` Cmd-` ``, `Cmd-q` in `iTerm2`

## Firefox Settings

Firefox settings in `about:config`:
- `browser.sessionstore.interval = 150000`
- `browser.cache.disk.enable = false`
- `browser.cache.memory.enable = true`
- `browser.cache.memory.capacity = -1`

## Licensing

The scripts and configurations are licensed under the MIT license.
