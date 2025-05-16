#!/bin/bash -e

if [ -z "$POSTGRES_HOST" -o -z "$POSTGRES_USER" -o -z "$POSTGRES_PASSWORD" -o -z "$POSTGRES_DB" ]; then
  echo "POSTGRES_HOST, POSTGRES_USER, POSTGRES_PASSWORD, and POSTGRES_DB must be set"
  exit 1
fi

# Check if the data directory is empty
if [ -z "$(ls -A /var/lib/postgresql/data)" ]; then
  echo "Initializing follower with pg_basebackup..."
  echo "$POSTGRES_HOST:5432:*:$POSTGRES_USER:$POSTGRES_PASSWORD" > ~/.pgpass
  chmod 0600 ~/.pgpass
  pg_basebackup -h $POSTGRES_HOST -p 5432 -U $POSTGRES_USER -D /var/lib/postgresql/data -Fp -Xs -P -R
  touch /var/lib/postgresql/data/standby.signal
fi

exec docker-entrypoint.sh postgres \
  -c "primary_conninfo=host=$POSTGRES_HOST port=5432 user=$POSTGRES_USER password=$POSTGRES_PASSWORD dbname=$POSTGRES_DB" \
  -c "primary_slot_name=replica_1" \
  -c "hot_standby=on" \
  -c "max_standby_archive_delay=300s" \
  -c "max_standby_streaming_delay=300s"
