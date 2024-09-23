## Linux Settings

- Ensure the `swap` partitions / files in `/etc/fstab` do not exceed a total of
  `max(4 GiB, 0.5 * RAM)`
- Update terminal settings:
  - Terminal > Preferences > Shortcuts:
    - New tab: `Ctrl-T`
    - New window: `Ctrl-N`
    - Close tab: `Ctrl-x`
    - Close window: `Ctrl-X`
    - Copy: `Ctrl-C`
    - Paste: `Alt-p`
    - Disable all "Switch to Tab #"
  - System > Settings > Keyboard > Keyboard Shortcuts > Custom Shortcuts:
    - Name: `Launch tmuxw in Gnome terminal`
    - Command:
      `gnome-terminal --window --maximize -- /bin/bash -c 'tmux new -A -s work'`
    - Shortcut: `Ctrl-Alt-t`
