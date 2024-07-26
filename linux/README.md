## Linux Settings

- Ensure the `swap` partitions / files in `/etc/fstab` do not exceed a total of
  `max(4 GiB, 0.5 * RAM)`
- Update terminal settings:
  - Terminal > Preferences > Shortcuts > Paste: `Alt-p`
  - System > Settings > Keyboard > Keyboard Shortcuts > Custom Shortcuts:
    - Name: `Launch tmuxw in Gnome terminal`
    - Command:
      `gnome-terminal --window --maximize -- /bin/bash -c 'tmux new -A -s work'`
    - Shortcut: `Ctrl-Alt-t`
