container_name=$1

# Fetch and define latest version of DB anonymisation function from isaac-api
cd isaac-api && git pull && cd - && < isaac-api/src/main/resources/db_scripts/create_anonymous_database.sql docker exec -i "$container_name" psql -v ON_ERROR_STOP=1 -U rutherford -f - --quiet

# Generate anonymous schema
echo "SELECT create_anonymous_database('$ANONYMISATION_SECRET');" | docker exec -i "$container_name" psql -v ON_ERROR_STOP=1 -U rutherford -f - --quiet
