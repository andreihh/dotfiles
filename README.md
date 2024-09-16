## Dotfiles

This is my personal dotfiles repository. It contains the specific dotfiles,
alongside an installation script.

### Installation

To install the dotfiles, run the following commands (requires `curl`):

```
GH_ROOT="https://raw.githubusercontent.com/andreihh/.dotfiles/master/installer"
curl -LO "$GH_ROOT/install.sh"
chmod +x install.sh
./install.sh
rm install.sh
```

To install the VIM plugins, run `vim` and type `:PlugInstall`.

To install the TMUX plugins, run `tmuxw` and type `Alt-a + I`.

### Private `~/.extras`

The `~/.extras` file should not be persisted across devices, and therefore is
not included in the repository. You should create it in the `$HOME` directory
and customize it appropriately. Example:

```
# ~/.extras: this file contains exported settings and installation paths for
# various software packages, making them available in interactive shells.

# Export Git credentials.
export GIT_AUTHOR_NAME="Andrei Heidelbacher"
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_AUTHOR_EMAIL="andrei.heidelbacher@gmail.com"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

...
```

### Code formatters

Update the `nvm` and code formatter versions in the setup scripts as needed. The
code formatters are configured to use Google style where possible. The following
formatters are configured:
- `shfmt`
- `prettier`
- `yapf`
- `clang-format`
- `google-java-format`
- `ktfmt`

### Firefox Settings

Firefox settings in `about:config`:
- `browser.sessionstore.interval = 150000`
- `browser.cache.disk.enable = false`
- `browser.cache.memory.enable = true`
- `browser.cache.memory.capacity = -1`

### Terminal Settings

Follow platform-specific instructions to update terminal settings:
- Paste with `Alt-p`
- Open a new maximized window in the `work` TMUX session with `Ctrl-Alt-t`

### Licensing

The scripts and configurations are licensed under the MIT license.
