container_name=$1

gunzip | docker exec -i "$container_name" psql -U rutherford -f -
