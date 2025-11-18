# RDS TLS Troubleshooting for Medusa Docker Deployments

## Problem

Medusa containers failed `npm run predeploy` with repeated `KnexTimeoutError` messages. Inside the runtime image, the Node `pg` client threw `SELF_SIGNED_CERT_IN_CHAIN` while `psql` succeeded because it already trusted the AWS RDS certificate authority.

## Root Cause

The runtime image lacked the Amazon RDS CA certificates. Without that trust bundle, Node could not validate the TLS chain for `*.rds.amazonaws.com`, so every connection attempt stalled until the pool timed out.

## Fix

1. **Configure Medusa database options** in `medusa-config.ts`:

   ```typescript
   databaseDriverOptions: {
     connection: { ssl: { rejectUnauthorized: false } },
   }
   ```

   This tells the Node `pg` client to accept self-signed certificates without strict validation.

2. **Add SSL parameter to database URL** in Terraform ECS environment variables:
   ```
   ?ssl_mode=disable
   ```
   Append this to the end of the `DATABASE_URL` environment variable to disable SSL mode enforcement at the connection level.

## Verification

- `node -e "const { Client } = require('pg'); …"` returns `[ { '?column?': 1 } ]`.
- `npm run predeploy` completes without Knex retries.
- `docker logs medusa` shows migrations succeeding during container startup.

## Future Containers

Bake the CA bundle download and `NODE_EXTRA_CA_CERTS` environment variable into the `Dockerfile` runner stage so every build trusts RDS automatically.
