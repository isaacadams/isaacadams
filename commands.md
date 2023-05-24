# Convert JSON from string

requires `jq` cli tool

```bash
echo <json> | jq -r $1 > data.json
```

```bash
# example
echo "{\"test\":{\"name\":\"Isaac Adams\",\"hobby\":\"Pokemon\"}}" | jq -r $1 > data.json
```
