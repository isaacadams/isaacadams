
# Overview

Documenting various use cases for the `gcloud` cli tool

# Configuration Directory

gcloud typically stores its configuration files in `~/.config/gcloud`, but if it is not there, you will find the path with the following command

```bash
gcloud info | grep 'User Config'
```

For windows, it will likely be in `%userprofile%\AppData\Roaming\gcloud`

There is a lot of useful information about your gcloud installation provided in `gcloud info`

# Auth Management

```bash
# list credentialed accounts
gcloud auth list
# add a new account
gcloud auth login
# change active account
gcloud set account `ACCOUNT`
# get access token
gcloud auth print-access-token
```

## Fetching Client Keys

the client key is used to authenticate with google and looks something like this

```json
{
  "client_id": "***",
  "client_secret": "***",
  "refresh_token": "***",
  "revoke_uri": "***",
  "scopes": [ ... ],
  "token_uri": "***",
  "type": "***",
}
```

### Service Account Client Keys

It is very easy to get the key for a service account using the CLI

```bash
gcloud iam service-accounts keys create `OUTPUT_FILEPATH`.json \
 --iam-account `SERVICE_ACCOUNT_NAME`@`PROJECT_ID`.iam.gserviceaccount.com
```

However, there is no equivalent command for users. Luckily, there is a way to fetch it. The details for that are in the next section.


### User Client Keys

After authenticating with `gcloud auth login`, gcloud stores the client keys in a local `credentials.db` file that is located in the configuration directory. Check the previous section entitled `Configuration Directory` for how to find that (tldr; `gcloud info | grep 'User Config'`).

Once the config directory has been located, there should be a file called `credentials.db`. It is a sqlite database, query it to find out what ables are inside (there should only be one).

```bash
sqlite3 credentials.db "SELECT name FROM sqlite_schema WHERE type='table' ORDER BY name;"
# > credentials
```

Now, lets query the `credentials` table

```bash
sqlite3 credentials.db "SELECT * FROM credentials;"
```

You can now obtain the client key(s) for any of the accounts credentialed on that machine.

# List roles associated with user or service account

```bash
#!/bin/env/bash
# $1 = project
# $2 = user:name@gmail.com or serviceAccount:name@gmail.com
gcloud projects get-iam-policy $1 --format=json | jq ".bindings[] | select(.members[] | contains(\"$2\")) | .role"
```