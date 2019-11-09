# Overview

Master and laptop branches are currently the same. Plan is to keep common configurations in master, and computer specific configurations in their own branches.

### How dotfiles are tracked: "bare repository and alias method"

```
$ git init --bare ~/.dotfiles
$ alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
$ config config status.showUntrackedFiles no
```

`config add <file-name>` etc.

### Master

| Shell | Window Manager | Editor | Terminal      | Monitor  |
| ----- | -------------- | ------ | ------------- | -------- |
| bash  | sway           | neovim | urxvt-unicode | i3status |

### Laptop

| Shell | Window Manager | Editor | Terminal      | Monitor  |
| ----- | -------------- | ------ | ------------- | -------- |
| bash  | sway           | neovim | urxvt-unicode | i3status |

### Desktop

| Shell | Window Manager | Editor | Terminal | Monitor |
| ----- | -------------- | ------ | -------- | ------- |
| tbd   | tbd            | tbd    | tbd      | tbd     |
