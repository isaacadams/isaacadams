
# Overview

Documenting various use cases for the `gcloud` cli tool

# Configuration Directory

gcloud typically stores its configuration files in `~/.config/gcloud`, but if it is not there, you will find the path with the following command

```bash
gcloud info | grep 'User Config'
```

For windows, it will likely be in `%userprofile%\AppData\Roaming\gcloud`

There is a lot of useful information about your gcloud installation provided in `gcloud info`

# Links & Documentation

- reference gcloud CLI: https://cloud.google.com/sdk/gcloud/reference/access-approval
- reference roles: https://cloud.google.com/iam/docs/understanding-roles
- reference permissions: https://cloud.google.com/iam/docs/permissions-reference

# Other

1. [Credentials Management](./credentials/README.md)
2. [Big Query](./bigquery.md)
