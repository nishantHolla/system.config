#!/bin/sh

symlink() {
  target=$(realpath "./$1")
  destination="$HOME/.config/$1"

  if [ -e "$destination" ]; then
    echo "WARN: $destination already exists. Skipping it";
    return 0;
  fi

  echo "Created link $destination -> $target"
  ln -s "$target" "$destination"
}

for dir in */; do
  dir="${dir%/}"
  symlink "$dir"
done
