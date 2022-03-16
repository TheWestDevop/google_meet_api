# File: epp/entrypoint.sh
#!/bin/bash
# docker entrypoint script.

# wait until Postgres is ready
# while ! pg_isready -U thewestdevop -d 'postgres://thewestdevop:eSLqfKu1303hnByaZ8O@0.0.0.0:5432/epp' -t 1;
# do
#   echo "$(date) - waiting for database to start"
#   sleep 2
# done

bin="/app/bin/google_meet_api"
# eval "$bin eval \"EPP.Release.migrate\""
# start the elixir application
exec "$bin" "start"