# nodejs

## Node Version Manager

I choose `fnm` (https://github.com/Schniz/fnm) as my node version manager. I have no problem with `nvm` except that it is not cross platform. And primarily use windows, but occasionally use linux and macos. So I really need my tools to be cross platform.

Install -> https://github.com/Schniz/fnm?tab=readme-ov-file#manually

## Config

find your current config: `npm config get userconfig`

find `bash` path: `which bash`

### `~/.yarnrc`

windows
```
script-shell "C:/Program Files/Git/usr/bin/bash"
```

### `~/.npmrc`

windows
```
script-shell=C:/Program Files/Git/usr/bin/bash
```
