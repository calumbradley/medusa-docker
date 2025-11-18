# RDS TLS Troubleshooting for Medusa Docker Deployments

## Problem

Medusa containers failed `npm run predeploy` with repeated `KnexTimeoutError` messages. Inside the runtime image, the Node `pg` client threw `SELF_SIGNED_CERT_IN_CHAIN` while `psql` succeeded because it already trusted the AWS RDS certificate authority.

## Root Cause

The runtime image lacked the Amazon RDS CA certificates. Without that trust bundle, Node could not validate the TLS chain for `*.rds.amazonaws.com`, so every connection attempt stalled until the pool timed out.

## Fix

1. Install CA and Postgres tooling in the runtime image (`apk add ca-certificates wget postgresql-client`) and refresh the trust store with `update-ca-certificates`.
2. Download the region-specific bundle: `wget https://truststore.pki.rds.amazonaws.com/eu-west-2/eu-west-2-bundle.pem -O /usr/local/share/ca-certificates/aws-rds.crt`.
3. Export `NODE_EXTRA_CA_CERTS=/usr/local/share/ca-certificates/aws-rds.crt` before launching Medusa so Node reuses the trusted CA chain.

## Verification

- `node -e "const { Client } = require('pg'); …"` returns `[ { '?column?': 1 } ]`.
- `npm run predeploy` completes without Knex retries.
- `docker logs medusa` shows migrations succeeding during container startup.

## Future Containers

Bake the CA bundle download and `NODE_EXTRA_CA_CERTS` environment variable into the `Dockerfile` runner stage so every build trusts RDS automatically.
