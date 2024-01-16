## convert stringified JSON to JSON

requires `jq` cli tool

```bash
echo <json> | jq -r $1 > data.json
```

```bash
# example
echo "{\"test\":{\"name\":\"Isaac Adams\",\"hobby\":\"Pokemon\"}}" | jq -r $1 > data.json
```

## convert JSON to stringified JSON

useful when loading a json object into an environment variable or as a single line in a `.env` file

```bash
JSON=$(cat ./key.json | jq -c '.' | sed 's/"/\\"/g' | sed 's/\\n/\\\\\\\\n/g')
echo $JSON
```

## replace characters using `sed`

```bash
# replace '"' with '""'
echo $(sed -e 's/"/""/g' data.json) > data2.json
```


# ffmpeg

```bash
# captures 10 frames per second in high quality from given input.mp4
ffmpeg -r 1 -i input.mp4 -r 1 -vf fps=10 %d.png
```
