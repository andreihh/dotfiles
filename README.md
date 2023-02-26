## Dotfiles

This is my personal dotfiles repository. It contains the specific dotfiles,
alongside an installation script.

### Installation

To install the dotfiles, run the following commands:

```
curl -LO https://raw.githubusercontent.com/andreihh/.dotfiles/master/install.sh
chmod +x install.sh
./install.sh
rm install.sh
```

To update the Vim plugins, run the following commands:

```
cd ~/.dotfiles
chmod +x sync_vim_plugins.sh
./sync_vim_plugins.sh
```

### Private `~/bin` and `~/.extras`

The `~/bin` directory and `~/.extras` file should not be persisted across
devices, and therefore are not included in the repository. You should create
them in the `$HOME` directory and customize them appropriately. Example:

```
# ~/.extras: this file contains exported settings and installation paths for
# various software packages, making them available in interactive shells.

# Export Git credentials.
GIT_AUTHOR_NAME="Andrei Heidelbacher"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="andrei.heidelbacher@gmail.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"

# Export Java SDK.
export JAVA_HOME="..."
export PATH="$PATH:$JAVA_HOME/bin"

...
```

### Recommended manual settings

- assert that the mounted Linux partitions in `/etc/fstab` use the `ext4` file
system and have the `relatime` option selected
- assert that there is a `swap` partition in `/etc/fstab` with size of at least
half of total RAM
- assert that `hibernate` is turned off
- set `vm.swappiness=1` in `/etc/sysctl.conf`
- assert that `cat /etc/cron.weekly/fstrim` returns `/sbin/fstrim --all || true`
- assert that `cat /sys/block/sda/queue/scheduler` returns the selected option
`[deadline]`
- Firefox settings in `about:config`:
  - `browser.sessionstore.interval = 150000`
  - `browser.cache.disk.enable = false`
  - `browser.cache.memory.enable = true`
  - `browser.cache.memory.capacity = -1`
  - `layout.css.devPixelsPerPx = 2.5` (for high DPI displays only)
- Display settings: UI scale set to `2.5` (for high DPI displays only)

### Licensing

The scripts and configurations are licensed under the MIT license.
