# Isaac Superset
Config for our deployment of Apache Superset.

## Contents
 * `superset`: Apache Superset config for a production deployment behind `router` (Nginx as a reverse proxy).
 * `anonymous_analysis_dbs`: Postgres config for the databases under analysis.

## Deployment
* Read the readme under [docker](superset/docker/README.md). 
* Run `TAG=[version] docker-compose -f docker-compse-prod.yml up -d`.