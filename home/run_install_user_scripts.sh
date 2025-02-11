#!/bin/bash
mkdir -p ~/.local/bin
find ~/github.com/lkdm/dotfiles/bin -type f \( -name "*.sh" -o -name "*.py" -o -name "*.rs" -o -name "*.ts" \) \
  -exec sh -c '
    source_file="{}"
    target_name="$(basename "{}" | sed "s/\.[^.]*$//")"
    ln -sf "$source_file" ~/.local/bin/"$target_name"
  ' \;

