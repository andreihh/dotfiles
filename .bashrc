# .bashrc

# Load configuration files:
# * `~/.bash_prompt` for terminal customization
# * `~/.exports` for environment variables exports
# * `~/.path` for extending the `PATH` variable
# * `~/.functions` for defining custom functions
# * `~/.aliases` for defining custom aliases
# * `~/.extras` for other settings that shouldn't be persisted
for file in ~/.{bash_prompt,exports,path,functions,aliases,extras}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Autocorrect typos in path names when using `cd`.
shopt -s cdspell

# Check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

# Append to the Bash history file, rather than overwriting it.
shopt -s histappend

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
