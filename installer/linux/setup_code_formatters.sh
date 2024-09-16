#!/bin/bash -e

# Installs code formatters specific for Linux systems.

readonly BIN="$HOME/.local/bin"

readonly GOOGLE_JAVA_FORMAT_BIN="google-java-format_linux-x86-64"
readonly GOOGLE_JAVA_FORMAT="https://github.com/google/google-java-format/releases/download/v1.23.0/$GOOGLE_JAVA_FORMAT_BIN"

readonly KTFMT_BIN="ktfmt-0.52-jar-with-dependencies.jar"
readonly KTFMT="https://github.com/facebook/ktfmt/releases/download/v0.52/$KTFMT_BIN"

[[ $# -gt 0 ]] && echo "Usage: $0" && exit 1

echo "Installing code formatters to '$BIN'..."

echo "Ensuring '$BIN' exists..."
mkdir -p "$BIN"
cd "$BIN"

echo "Installing yapf..."
pip install yapf

echo "Installing prettier..."
npm install --save-dev --save-exact prettier
npx prettier --version

for url in "$GOOGLE_JAVA_FORMAT" "$KTFMT"; do
  echo "Downloading '$url'..."
  curl -LO "$url"
done

echo "Setting up wrappers..."
ln -s -T "$BIN/$GOOGLE_JAVA_FORMAT_BIN" "$BIN/google-java-format"
cat << EOF > ktfmt
#!/bin/bash

java -jar $BIN/$KTFMT_BIN --google-style "\$@"
EOF
chmod +x google-java-format ktfmt

echo "Code formatters installed!"
