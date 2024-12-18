# Welcome

I am falling in love with nushell. I cannot tell if this will be good or bad. Probably bad.

## Creating Commands

- https://archive.ph/TjEJ8
- https://www.nushell.sh/cookbook/jq_v_nushell.html#appendix-custom-commands


## Dataframes & SQLite

https://www.nushell.sh/lang-guide/chapters/types/other_types/custom_value.html#additional-language-notes

## Plugins

There is a package ecosystem (plugins) in nushell, but installing them and managing is unfortunately a bit complex. I haven't played around with plugins much, but this looks like a helpful article:

- https://qqq.ninja/blog/post/nushell-install-plugins/

## Recipes

### loading .env file w/ comments

how to load .env files that look like the following:

```
# this is some api token
API_TOKEN=xxxxxxxxx
# another comment
AWS_SECRET=xxxxxxxxx
```

credit: https://stackoverflow.com/questions/77383686/set-environment-variables-from-file-of-key-value-pairs-in-nu

```nu
open .env.local
    | lines
    | split column "#"
    | get column1
    | filter {($in | str length) > 0}
    | parse "{key}={value}"
    | update value {str trim -c '"'}
    | transpose -r -d
```

