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

# Opens ZSH in minitol
open_minitol_shell() {
    container_id=$(get_minitol_container_id)
    if [ -n "$container_id" ]; then
        echo "Found Minitol container with ID ${container_id}. Attempting to run..."
        docker exec -it "$container_id" zsh
    else
        echo "No running Minitol container found."
    fi
}

execute_branch_sync() {
    container_id=$(get_minitol_container_id)
    if [ -n "$container_id" ]; then
        echo "Found Minitol container with ID ${container_id}. Attempting to run..."
        docker exec -it "$container_id" bash -c "
            branch-sync
        "
    else
        echo "No running Minitol container found."
    fi
}

execute_clone_db() {
    container_id=$(get_minitol_container_id)
    if [ -n "$container_id" ]; then
        echo "Found Minitol container with ID ${container_id}. Attempting to run..."

        # Join all arguments into a single command
        command="$*"

        docker exec -it "$container_id" bash -c "
            dbclone $command
        "
    else
        echo "No running Minitol container found."
    fi
}

configure_ts() {
    echo "Not implemented"
}

# Starts Docker Engine then starts the dev app in the container
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
        echo "Could not start Minitol container."
    fi
}

help() {
	echo "mt is a comprehensive suite of tools to streamline Minitol development on POSIX-based systems (Linux, macOS).

Usage: mt <subcommand> [options]

AVAILABLE SUBCOMMANDS

development environment
    start                     Launch Docker engine and initialise the dev environment
    sh                        Access a ZSH shell within the dev container or run a command
    id                        Get the dev container's ID

database operations
    sql                       Execute a SQL script on the dev database
    slqsh \"<sh>\"              Launch an interactive SQL shell connected to the dev database
    clone <db1> [<db2>, ...]  Clone databases from production, separated by spaces

version control
    branch-sync               Run branch synchronisation script inside the dev container

linting
    ts <1,0>                  Enable or disable strict type checking for the Typescript compiler

general
    help                      Display this help message

EXAMPLES

    mt start
    mt sql 'SELECT * FROM table LIMIT 1;'
    mt clone hr_166 hr_338
    mt branch-sync
    mt ts 1

Ensure Docker engine is installed and properly configured on your system before using this tool.
See: https://docs.docker.com/engine/install/
	"
}
# Main script logic
if [ $# -eq 0 ]; then
    help
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
    branch-sync)
        execute_branch_sync "$@"
        ;;
    clone)
        execute_clone_db "$@"
        ;;
    ts)
        configure_ts "$@"
        ;;
    start)
        start "$@"
        ;;
    help)
    	help "$@"
    	;;
    *)
        echo "mt: $subcommand is not a subcommand. See: mt help"
        exit 1
        ;;
esac

