# 👋 GPG Guide

Knowledge base for getting started with GPG and configuring git to use it for signing commits

# Getting Started

## 📥 Installation

- windows: [gpg for windows (kleopatra)](https://www.gpg4win.org/features.html)
- linux/ubuntu: `sudo apt-get install gnupg`
- mac: `brew install gnupg`

## Connect git with GPG by Updating `~/.gitconfig`

git needs the `signingkey` for `gpgsign = true` to work

the following updates can be made and the rest of the instructions involve obtaining the missing `signingkey`

```
# ~/.gitconfig 
[user]
    name = Your Name
    email = your@email.com
    signingkey = <signing key>

[commit]
    gpgsign = true

# if installed gpg through homebrew
[gpg]
    program = /opt/homebrew/bin/gpg
```

## Generate GPG Keys

[github guide for generating GPG keys](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key)

generate new key [docs](https://gnupg.org/documentation/manuals/gnupg/OpenPGP-Key-Management.html) with the following properties

- no passphrase: `--passphrase ''`
- userid and email: `"YOUR NAME <your-email@gmail.com>"`
- algo: `rsa4096`
- usage: `default`
- expires: `never`

```bash
gpg --batch --passphrase '' --quick-gen-key "YOUR NAME <your-email@gmail.com>" rsa4096 default never
```

### Import Keys into GPG

```bash
# import keys into GPG
gpg --import < ~/.gnupg/file_name_private_key.gpg
gpg --import < ~/.gnupg/file_name_public_key.gpg
```

### Export Keys from GPG

```bash
# get public key in ASCII armor format
gpg --list-secret-keys --keyid-format=long
```

example output

```
/Users/hubot/.gnupg/secring.gpg
------------------------------------
sec   4096R/3AA5C34371567BD2 2016-03-10 [expires: 2017-03-10]
uid                          Hubot
ssb   4096R/42B317FD4BA89E7A 2016-03-10
```

grab the value adjacent to `sec XXXXR/<signingkey>`\
`3AA5C34371567BD2` => this is your `signingkey`!\
you can now go back to `~/.gitconfig` and update that accordingly

last thing to do is upload the public key to github

```bash
# export public key
gpg --armor --export 3AA5C34371567BD2 > public-key.txt
# copy the content of public-key.txt and paste it into a new GPG key in github
```

the following command is how you export your private key, but that is not a required action for this tutorial

```bash
# export your private key WARNING! DO NOT SHARE YOUR PRIVATE KEY!
gpg --export-secret-keys -a 3AA5C34371567BD2 > private-key.txt
```

# Library

- [devdungeon](https://www.devdungeon.com/content/gpg-tutorial)

# ❓ Help

## General Knowledge

The `pubring.kbx` file is where the keys loaded into gpg are stored.

This file may exist in

- `~/.gnupg`
- `~/AppData/Roaming/gnupg/pubring.kbx`

## Linux/WSL

tips for linux machines

### Using GPG on WSL2 through VSCode

This is a tricky situation since git is going to use the keys on WSL2 instance to sign the commit, but VSCode is installed on the windows side. When signing, a passphrase is required and this will open a GUI for inputting that passphrase. The gpg-agent needs to be told to use the windows side GUI.

Ensure the following is added to the `gpg-agent.confg` file.

`~/.gnupg/gpg-agent.conf`

```conf
default-cache-ttl 34560000
max-cache-ttl 34560000
# windows
pinentry-program "/mnt/c/Program Files (x86)/GnuPG/bin/pinentry-basic.exe"
# mac/homebrew
pinentry-program "/opt/homebrew/bin/pinentry"
```

The run the following: `gpgconf --kill gpg-agent`

The above is based on this [guide](https://www.39digits.com/signed-git-commits-on-wsl2-using-visual-studio-code)

### Transfer Keys From Windows to WSL

```bash
# run this on the windows machine
gpg --homedir ~/.gnupg --export-secret-keys -a 57A5CDC5B4E63EF4 > //wsl.localhost/Ubuntu/home/<WSL-NAME>/private-key.txt
```

```bash
# run the following on WSL2
gpg --import < ~/private-key.txt
```