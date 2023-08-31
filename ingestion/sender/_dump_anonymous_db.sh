container_name=$1

docker exec -i "$container_name" pg_dump -U rutherford --schema=anonymous --clean --if-exists | gzip
