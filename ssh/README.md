# SSH Guide

knowledge base for ssh

## Generate Public Key from Private Key

```bash
ssh-keygen -y -f ~/.ssh/id_rsa > public.pub
```

see the [SSH guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh) provided by github

## Creating a new key

```bash
# generate your new ssh key
ssh-keygen -t ed25519 -C "your_email@example.com"
# start up the ssh agent
eval "$(ssh-agent -s)"
# add ssh key to ssh agent (point to private key)
ssh-add ~/.ssh/id_ed25519
# copy public key for registering to external service
clip < ~/.ssh/id_ed25519.pub
```

## Configure SSH Host

configure hosts for communicating through SSH on your server 

[more information on how to configure the config file](https://linux.die.net/man/5/ssh_config)

~/.ssh/config
```txt
Host github.com-some-unique-name
    HostName github.com
    User git
    IdentityFile ~/.ssh/point_to_rsa_pk
```

## Tunneling

you can tunnel http traffic through a local container

```bash
#startup
docker compose -f ssh.yml up -d
#shutdown
docker compose -f ssh.yml down --remove-orphans
```

## Configuring network tunneling through SSH & Firefox

```
$ start ssh -R 19999:localhost:22 isaac@192.168.1.221
```

[great article on ssh tunneling](https://www.howtogeek.com/168145/how-to-use-ssh-tunneling/)

| kind    | command                                                          |
| ------- | ---------------------------------------------------------------- |
| local   | ssh -L local_port:remote_address:remote_port username@server.com |
| remote  | ssh -R remote_port:local_address:local_port username@server.com  |
| dynamic | ssh -D local_port username@server.com                            |

- open putty and ssh into the container
- change firefox settings to proxy the socks port

## Research

- parameterized config entries: https://superuser.com/questions/1834663/ssh-parameterized-config-entries
- automating ssh settings for devcontainers: https://www.kenmuse.com/blog/automatic-ssh-commit-signing-with-dotfiles/
- gpg/ssh?: https://www.reddit.com/r/linux/comments/6k8nw3/killed_two_days_figuring_out_how_to_use_gpg_keys/