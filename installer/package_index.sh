# The index of required packages for all platforms.

# Common core packages (available both through `apt` and `brew`).
readonly CORE_PACKAGES=\
"firefox wget curl git vim tmux lm-sensors tree urlview calc dos2unix "

# Linux core packages (available through `apt`).
readonly LINUX_CORE_PACKAGES=\
"vim.gtk3 xsel silversearcher-ag xclip zenity tlp snapd "\
"linux-tools-common linux-tools-generic "

# MacOS core packages (available through `brew`).
readonly MACOS_CORE_PACKAGES=\
"reattach-to-user-namespace the_silver_searcher pngpaste"

# Linux LaTeX packages (available through `apt`).
readonly LINUX_LATEX_PACKAGES=\
"texlive texlive-latex-extra texlive-science texlive-fonts-extra latexmk "\
"texlive-bibtex-extra biber "

# MacOS LaTeX packages (available through `brew`).
readonly MACOS_LATEX_PACKAGES=\
"mactex biber"

# Linux development packages (available through `apt`).
readonly LINUX_DEVELOPMENT_PACKAGES=\
"python3 python-is-python3 "\
"openjdk-21-jdk "\
"build-essential cmake clang-format "\
"shfmt "

# MacOS development packages (available through `brew`).
readonly MACOS_DEVELOPMENT_PACKAGES=\
"python3 yapf "\
"openjdk google-java-format ktfmt"\
"gcc cmake clang-format "\
"shfmt prettier "

# Common media CLI packages (available both through `apt` and `brew`).
readonly MEDIA_CLI_PACKAGES=\
"pdftk-java ffmpeg graphviz plantuml "

# Common media GUI packages (available both through `apt` and `brew --cask`).
readonly MEDIA_GUI_PACKAGES=\
"keepassxc vlc "

# All required Linux packages (available through `apt`).
readonly LINUX_PACKAGES=\
"$CORE_PACKAGES "\
"$LINUX_CORE_PACKAGES "\
"$LINUX_LATEX_PACKAGES "\
"$LINUX_DEVELOPMENT_PACKAGES "\
"$MEDIA_CLI_PACKAGES "\
"$MEDIA_GUI_PACKAGES "

# All required MacOS packages (available through `brew`).
readonly MACOS_PACKAGES=\
"$CORE_PACKAGES "\
"$MACOS_CORE_PACKAGES "\
"$MACOS_LATEX_PACKAGES "\
"$MACOS_DEVELOPMENT_PACKAGES "\
"$MEDIA_CLI_PACKAGES "

# All required GUI MacOS packages (available through `brew --cask`).
readonly MACOS_GUI_PACKAGES=\
"$MEDIA_GUI_PACKAGES "
