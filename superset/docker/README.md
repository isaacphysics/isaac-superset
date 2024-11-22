# Isaac Superset using Docker
This directory contains config for running Superset in production using Docker Compose. This is based on the [upstream official Superset repo](https://github.com/apache/superset/tree/master/docker), but differs somewhat.

As of v4, the upstream "no longer supports" production deployments with Docker Compose, but it hasn't changed much and still suits our use-case better.

## Configuration
To outline the process of defining and loading config:

 * `.env-prod` defines `PYTHONPATH=[...]:/app/docker/pythonpath_prod`, adding `pythonpath_prod` to the `PYTHONPATH`[^1].
 * This introduces `superset_config.py` as the source of config, which loads some config properties from other env vars defined in `.env-prod`[^2]. Some additional config properties are hard-coded in `superset_config.py` (as they are in the upstream)[^3].

## Updating Superset
1. Back up the existing metadata DB with `backup-postgres.sh` (important!).
2. Apply any relevant config changes:
    * Check the upstream [compose file](https://github.com/apache/superset/blob/master/docker-compose-image-tag.yml) and apply any relevant changes to our `docker-compose-prod.yml`
    * Check the upstream [superset_config.py](https://github.com/apache/superset/blob/master/docker/pythonpath_dev/superset_config.py) and apply any relevant changes to our `superset_config.py`
    * Check the upstream [.env](https://github.com/apache/superset/blob/master/docker/.env) and apply any relevant changes to our `.env-prod`
3. Update and raise containers using `TAG=[new version] docker-compose -f docker-compse-prod.yml up -d`
4. Test that the automatic migration worked by trying a few things - loading dashboards, querying in SQL Lab, etc.
    * Ensure that you also test as a user with locked-down permissions - permissions have been broken by migrations in the past. 
5. If it didn't work, don't let it run in a broken state. Lower the containers again `TAG=[new version] docker-compose -f docker-compse-prod.yml down`.
6. If you need to roll back, revert the config from step 2 and restore the old metadata DB from step 1 with `restore-postgres.sh`.

* If the migration isn't working, another option is re-creating at the latest version from scratch and using the export/import features in the UI to move over dashboards, charts etc. 

---

[^1]: Here, `pythonpath_prod` replaces `pythonpath_dev` from the upstream repo. 
[^2]: `.env-prod` (not checked-in) replaces the upstream `.env`.
[^3]: `superset_config.py` in the upstream repository imports another file for "local overrides" named `superset_config_docker.py`. To simplify things, I instead added logic to `superset_config.py` to load additional properties such as `SECRET_KEY` straight from `.env-prod`.

