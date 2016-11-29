## Dotfiles

This is my personal dotfiles repository.

It contains the specific dotfiles, along with an installation script.

### Installation

```
cd ~
git clone --recursive https://github.com/andrei-heidelbacher/.dotfiles.git
cd .dotfiles
chmod +x install.sh
./install.sh
```

### Recommended manual settings

- set `vm.swappiness=10` in `/etc/sysctl.conf`
- assert that `hibernate` is turned off
- assert that there is a `swap` partition in `/etc/fstab` with size of at least
half of total RAM
- add `noatime` option to all regular partitions in `/etc/fstab` (except for the
`swap` partition or other special partitions)
- assert that `cat /etc/cron.weekly/fstrim` returns `/sbin/fstrim --all || true`
- assert that `cat /sys/block/sda/queue/scheduler` returns the selected option
`[deadline]`
- Firefox settings in `about:config`:
  - `browser.sessionstore.interval = 150000`
  - `browser.cache.disk.enable = false`
  - `browser.cache.memory.enable = true`
  - `browser.cache.memory.capacity = -1`

### Licensing

The scripts and configurations are licensed under the MIT license.
