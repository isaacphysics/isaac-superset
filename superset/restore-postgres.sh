file_to_restore=$1

gunzip -c "$file_to_restore" | docker exec -i superset_v6_db psql -U superset -f -