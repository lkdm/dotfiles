#!/bin/bash
# Minitol CLI tool


# Returns the ID for the Minitol Dev Container
get_minitol_container_id() {
    docker ps -q --filter name=minitol-app
}

# Executes the input as SQL
execute_sql_in_container() {
    if [ -z "$MINITOL_DB_PASSWORD" ]; then
        echo "Error: MINITOL_DB_PASSWORD environment variable is not set."
        return 1
    fi

    container_id=$(docker ps -q --filter name=minitol-mariadb)
    if [ -n "$container_id" ]; then
        echo "Found Minitol MariaDB container with ID ${container_id}. Executing command..."

        # Join all arguments into a single command
        command="$*"

        # Execute the MySQL command and print the output
        docker exec -it "$container_id" bash -c "
            mysql -p'$MINITOL_DB_PASSWORD' -e \"$command\"
        "
    else
        echo "No running Minitol container found."
    fi
}

# Opens the MySQL shell
open_sql_repl_in_container() {
    if [ -z "$MINITOL_DB_PASSWORD" ]; then
        echo "Error: MINITOL_DB_PASSWORD environment variable is not set."
        return 1
    fi
    container_id=$(docker ps -q --filter name=minitol-mariadb)
    if [ -n "$container_id" ]; then
        echo "Found Minitol MariaDB container with ID ${container_id}. Attempting to run..."
        docker exec -it "$container_id" bash -c "
            mysql -p'$MINITOL_DB_PASSWORD'
        "
    else
        echo "No running Minitol container found."
    fi
}

open_minitol_shell() {
    container_id=$(get_minitol_container_id)
    if [ -n "$container_id" ]; then
        echo "Found Minitol container with ID ${container_id}. Attempting to run..."
        docker exec -it "$container_id" zsh
    else
        echo "No running Minitol container found."
    fi
}

start() {
	nohup docker compose -p minitol -f ~/trionline/.devcontainer/docker-compose.yml up -d > ~/logs/minitol.out 2>&1 </dev/null &
	sleep 0.5
	container_id=$(get_minitol_container_id)
    if [ -n "$container_id" ]; then
        echo "Started Minitol container with ID ${container_id}. Attempting to run..."
        docker exec -it "$container_id" bash -c "
        	start
        "
    else
        echo "No running Minitol container found."
    fi
}

# Main script logic
if [ $# -eq 0 ]; then
    echo "Usage: $0 <subcommand> [options]"
    exit 1
fi

subcommand="$1"
shift

case "$subcommand" in
    id)
        get_minitol_container_id "$@"
        ;;
    sql)
        execute_sql_in_container "$@"
        ;;
    sh)
        open_minitol_shell "$@"
        ;;
    sqlsh)
        open_sql_repl_in_container "$@"
        ;;
    start)
        start "$@"
        ;;
    *)
        echo "Error: Unknown subcommand '$subcommand'"
        echo "Usage: $0 {compile|debug|mogrify} [options]"
        exit 1
        ;;
esac

