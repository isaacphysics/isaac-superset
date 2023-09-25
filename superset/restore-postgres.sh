file_to_restore=$1

gunzip -c "$file_to_restore" | docker exec -i superset_db psql -U superset -f -