#!/bin/sh

symlink() {
  target="$1"
  destination="$HOME/.config/$2"

  if [ -e "$destination" ]; then
    echo "WARN: $destination already exists. Skipping it";
    return 0;
  fi

  echo "Created link $destination -> $target"
  ln -s "$target" "$destination"
}

for dir in ./config/*/; do
  [ -d "$dir" ] || continue
  abs_path=$(realpath "$dir")
  dir_name=$(basename "$dir")
  symlink "$abs_path" "$dir_name"
done
