# `grep` commands

```bash
# search for pikachu
grep "pikachu" \
      # r: recursive
      # H: display filename for each match
      # n: display line matched
      -rHn \
      # in all kinds of files (ie not limited by filename or extension)
      --include=*.* \
      # exclude these directories
      --exclude-dir={target,node_modules,.parcel-cache,syncbase,.oxen} \
      # show folders while searching
      --directories=recurse \
      # dump everying into findings.txt
      > findings.txt
```