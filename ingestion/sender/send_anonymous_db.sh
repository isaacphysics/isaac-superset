local_container_name="$1"
remote_container_name="$2"

echo "** Generating anonymous schema for $local_container_name **"
./_generate_anonymised_schema.sh "$local_container_name" || { echo "Failed to generate anonymous schema, exiting!" && exit 1; }

echo "** Sending anonymous schema to remote $remote_container_name **"
# shellcheck disable=SC2029
./_dump_anonymous_db.sh "$local_container_name" | ssh "$ANON_DB_RECEIVER" ./_load_anonymous_db.sh "$remote_container_name"

exit_code=$?
if [ $exit_code -eq 0 ]; then
        echo "** Done! **" && exit 0
else
        echo "** Failed to send anonymous schema! **" && exit 1
fi
