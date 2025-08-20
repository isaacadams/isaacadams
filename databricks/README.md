

## Installation (CLI)

docs: https://docs.databricks.com/aws/en/dev-tools/cli/install

brew
```sh
brew tap databricks/tap
brew install databricks
```

## Authentication

docs: https://docs.databricks.com/aws/en/dev-tools/cli/authentication

```
ls ~/.databrickscfg
```

Keep in mind, there are two different contexts: the account and the workspace. Each context has its own access parameters.

For account-level commands

```
[<some-unique-configuration-profile-name>]
host          = <account-console-url>
account_id    = <account-id>
client_id     = <service-principal-client-id>
client_secret = <service-principal-oauth-secret>
```

For workspace-level commands

```
[<some-unique-configuration-profile-name>]
host          = <workspace-url>
client_id     = <service-principal-client-id>
client_secret = <service-principal-oauth-secret>
```