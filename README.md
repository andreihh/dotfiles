## Dotfiles

This is my personal dotfiles repository. It contains the specific dotfiles,
alongside an installation script.

### Installation

To install the dotfiles, run the following commands:

```
wget https://raw.githubusercontent.com/andreihh/.dotfiles/master/install.sh
chmod +x install.sh
./install.sh
rm install.sh
```

### Private `~/bin` and `~/.extras`

The `~/bin` directory and `~/.extras` file should not be persisted across
devices, and therefore are not included in the repository. You should create
them in the `$HOME` directory and customize them appropriately. Example:

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

### Recommended manual settings

- Ensure that the `swap` partitions / files in `/etc/fstab` do not exceed a
  total of `max(4 GiB, 0.5 * RAM)`
- Update terminal preferences:
  - Terminal > Preferences > Shortcuts > Paste: `Alt-p`
  - System > Settings > Keyboard > Keyboard Shortcuts > Custom Shortcuts:
    - Name: `Launch tmuxw in Gnome terminal`
    - Command:
      ```
      gnome-terminal --window --maximize -- \
        /usr/bin/bash -c 'tmux new -A -s work'
      ```
    - Shortcut: `Ctrl-Alt-t`
- Firefox settings in `about:config`:
  - `browser.sessionstore.interval = 150000`
  - `browser.cache.disk.enable = false`
  - `browser.cache.memory.enable = true`
  - `browser.cache.memory.capacity = -1`

### Licensing

The scripts and configurations are licensed under the MIT license.
