# Isaac Superset using Docker
This directory contains config for running Superset in production using Docker Compose. This is based on the [upstream official Superset repo](https://github.com/apache/superset/tree/master/docker), but differs somewhat.

To outline the process of defining and loading config:

 * `.env-prod` defines `PYTHONPATH=[...]:/app/docker/pythonpath_prod`, adding `pythonpath_prod` to the `PYTHONPATH`[^1].
 * This introduces `superset_config.py` as the source of config, which loads some config properties from other env vars defined in `.env-prod`[^2]. Some additional config properties are hard-coded in `superset_config.py` (as they are in the upstream)[^3].

When updating Superset, it's worth checking the upstream [superset_config.py](https://github.com/apache/superset/blob/master/docker/pythonpath_dev/superset_config.py) and [.env-non-dev](https://github.com/apache/superset/blob/master/docker/.env-non-dev) for relevant changes and applying them to `superset_config.py` and `.env-prod` respectively.

---

[^1]: Here, `pythonpath_prod` replaces `pythonpath_dev` from the upstream repo. 
[^2]: `.env-prod` (not checked-in) replaces the upstream `.env-non-dev`.
[^3]: `superset_config.py` in the upstream repository imports another file for "local overrides" named `superset_config_docker.py`. To simplify things, I instead added logic to `superset_config.py` to load additional properties such as `SECRET_KEY` straight from `.env-prod`.

