#!/bin/bash
#
# ~/.xinitrc: executed by startx.

[ -f "$HOME/.Xresources" ] && xrdb -merge "$HOME/.Xresources"
