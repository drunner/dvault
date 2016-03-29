# dVault
 Helper container for dRunner managed services using HashiCorp Vault. Can be used in service runner to populated a volume with required secrets on install/upgrade if no Vault support is built into the application.
 
 dVault helps manage secrets for dRunner across multiple environments (production, dev, etc) by automatically splitting secret storage location depending on the context set.
 
 You may also specify a metafile `dvault.json` which can reference other secrets stored anywhere in Vault. This is particuarly useful for fairly static secrets that are shared between projects, e.g. SSL certificates.

## Installation
How to install and configure dvault

```
drunner install drunner/dvault
VAULT_ADDR=? VAULT_TOKEN=? VAULT_CONTEXT=? dvault configure
```

#### VAULT_ADDR
The address of HashiCorp Vault, e.g. `https://vault.example.com:8200`

#### VAULT_TOKEN
Token with a read and write access to `secret/dvault` at least

#### VAULT_CONTEXT
Arbitrary environment where dVault is running, could be `live`, `staging`, `dev`, etc.

## Usage
Basic Vault commands are available to add, list and remove secrets as well as view or set context.

### Adding Secrets
Secrets are added as files where the filename is the key and the contents is the value:

```
dvault add my_project my_secret_file
```

The file `my_secret_file` will be added to `my_project` under the configured context.

### Viewing Secrets
You can view all secrets for a project/context using:

```
dvault list my_project
```

### Deleting Secrets
Deleting is similar to adding:

```
dvault delete my_project my_secret
```

This will only delete the secret from the current context.

### Changing Contexts
You can change the context dVault is in or view the current context with:

```
dvault context new_context
```

### Reference Other Secrets
Adding a special file `dvault.json` tells dVault to fetch secrets from other locations within Vault when secrets are loaded into a volume. This is especially useful for shared secrets (SSL certificates, etc) because if the secret is updated all services using it will receive the new version immediately.

The format of the file is as follows:

```json
{
   "live": [
      "ssl/production.crt",
      "ssl/production.key"
   ],
   "staging": [
      "ssl/internal.crt",
      "ssl/internal.key"
   ],
   "dev": [
      "ssl/dev-selfsigned.crt",
      "ssh/external-resource.pem"
   ]
}
```

And can be added to Vault like any other secret:

```
dvault add my_project dvault.json
```

## Development
Instructions for developing dvault
