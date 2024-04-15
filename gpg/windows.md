# GPG on Windows

While I was playing around with devcontainers, I discovered that there were *three* separate `gpg` installations on my windows machine, all with separate `.gnupg` folders. This occurred to me after I attempted to sign a commit from within the devcontainer and I got an error. This struck me as odd because the devcontainer should be using my host machine gpg configuration. Well, it was, just not the one I thought.

On my host windows machine, I opened up Kleopatra and realized it was loading a separate keyring than the one I expected. After some digging, I discovered a total of three `gpg` installations.

1. git
- gnupg: `~/.gnupg`
- gpg: `c:\Program Files\Git\usr\bin\gpg`
2. GPG for Windows
- gnupg: `~/AppData/Roaming/gnupg`
- gpg: `/c/Program Files (x86)/GnuPG/bin/gpg`
3. scoop
- gnupg: `~/scoop/apps/gpg/gnupg`
- gpg: `~/scoop/apps/gpg/2.4.3/bin/gpg`

What a mess! I eventually want to consolidate this down to ONE installation and use `~/.gnupg` as the home directory for `gpg`.

For now, I will settle for moving all my keys into the gpg keyring that my machine appears to use as the default, which is the gpg for windows installation which uses `~/AppData/Roaming/gnupg`.

## Moving Keys

```bash
# using the gpg cli tool for the store that has your keys to port
# run this command to get a list of all the private keys you need to port
gpg --list-secret-keys --keyid-format=long > list.txt
```

```bash
# export.sh
gpg --export-secret-keys -a $1 > private-key-$1
```

```bash
# export all your keys, where XXX/YYY/ZZZ are the ids
bash export.sh XXX
bash export.sh YYY
bash export.sh ZZZ
```

```bash
# using the gpg cli for the store you need your keys in, run:
gpg --import ./private-key-XXX
```

## Changing Home

If you set `GNUPGHOME` to whatever `gnupg` folder you want, then reloading kleopatra will load up the keyring in that folder. Kleopatra defaults to using `~/AppData/Roaming/gnupg`, if you wanted to use Kleopatra for `~/.gnupg`:

```bash
export GNUPGHOME=~/.gnupg
```
