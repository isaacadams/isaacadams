# Git for Windows

typical installation directory: C:\Program Files\Git

settings: C:\Program Files\Git\etc\profile.d

`profile.d/git-prompt.sh` override: ~/.config/git/git-prompt.sh


## ~/.config/git/git-prompt.sh

- removes machine user + machine name and replaces it w/ a custom name
- removes `MING64W`
- only shows parent directory instead of full path
- shows time of day

NOTE: replace `<YOUR-NAME> `

```sh
PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]' # set window title
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'\[\033[32m\]'       # change to green
PS1="$PS1"'<YOUR-NAME> '       # show your custom name
PS1="$PS1"'\[\033[33m\]'       # change to brownish yellow
PS1="$PS1"'\W'                 # current working directory
PS1="$PS1"'\[\033[35m\]'       # change to purple
PS1="$PS1"'\D{%H:%M:%S} '      # show current time
if test -z "$WINELOADERNOEXEC"
then
    GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
    COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
    COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
    COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
    if test -f "$COMPLETION_PATH/git-prompt.sh"
    then
        . "$COMPLETION_PATH/git-completion.bash"
        . "$COMPLETION_PATH/git-prompt.sh"
        PS1="$PS1"'\[\033[36m\]'  # change color to cyan
        PS1="$PS1"'`__git_ps1`'   # bash function
    fi
fi
PS1="$PS1"'\[\033[0m\]'        # change color
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'$ '                 # prompt: always $
```