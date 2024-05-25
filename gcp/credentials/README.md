# Google Cloud Credentials Management

## General Authentication Management via `gcloud`

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

## Service Accounts

Programmatic access to bigquery is implemented via service accounts. This guide serves to help you easily jumpstart a service account for bigquery access. The commands are defined in the [justfile](./justfile).

### Provision a new Service Account

1. Create service account

```sh
just service-account-create my-biquery-service-account "data in bigquery is accessed for X purpose"
```

2. Add the permissions/roles to the service account which are needed to access bigquery data programatically

```sh
just service-account-bq-roles my-project-id my-biquery-service-account
```

3. You can check to see that the roles were added using the following command

```sh
just service-account-roles-print my-project-id my-biquery-service-account
```

### Generate key for Service Account

You can create multiple keys for any given service account. These key files must be kept PRIVATE! If they ever become compromised, stolen, etc., then you should delete them immediately.

These key files look something like this:

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

> DO NOT SHARE THIS JSON FILE ANYWHERE (EXCEPT ON GITHUB THROUGH THIS PROCESS)

It is very easy to generate a new key file on your machine. Simply run the following:

```sh
just service-account-key my-biquery-service-account ./key.json
```

## Under the Hood

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

You can now obtain the client key(s) for any of the accounts that have logged in on that machine.
