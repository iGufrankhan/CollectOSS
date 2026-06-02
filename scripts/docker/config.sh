#!/bin/bash

PS3="
Please type the number corresponding to your selection and then press the Enter/Return key.
Your choice: "

target=$1

function blank_confirm() {
    if [ -z "${1}" ]; then
        echo "Bad usage of blank_confirm at:"
        caller
        return
    fi

    confirm_placeholder=${!1}

    while [ -z "${confirm_placeholder}" ]; do
        echo "You entered a blank line, are you sure?"
        read -p "enter 'yes' to continue, or enter the intended value: " confirm_placeholder
        case "$confirm_placeholder" in
        [yY][eE][sS] | [yY][eE] | [yY])
            return
            ;;
        *)
            continue
            ;;
        esac
    done
    printf -v "$1" "%s" $confirm_placeholder
}

function get_github_username() {
    echo
    echo "Please provide your username for Github."
    echo "** This is required for CollectOSS to clone Github repos ***"
    read -p "GitHub username: " github_username
    blank_confirm github_username
    echo
}

function get_github_api_key() {
    echo
    echo "Please provide a valid GitHub API key."
    echo "For more information on how to create the key, visit:"
    echo "https://docs.collectoss.org/en/latest/getting-started/collecting-data.html"
    echo "** This is required for CollectOSS to gather data ***"
    read -p "GitHub API Key: " github_api_key
    blank_confirm github_api_key
    echo
}

function get_rabbitmq_broker_url() {
    echo
    echo "Please provide your rabbitmq broker url."
    echo "** This is required for CollectOSS to run all collection tasks. ***"
    read -p "broker_url: " rabbitmq_conn_string
    blank_confirm rabbitmq_conn_string
    echo
}

function create_config() {

    if [[ -z "${AUGUR_GITHUB_API_KEY}" ]]; then
        get_github_api_key
    else
        echo
        echo "Found AUGUR_GITHUB_API_KEY environment variable"
        echo "Using it in the config"
        echo "Please unset AUGUR_GITHUB_API_KEY if you would like to be prompted for a github api key"
        github_api_key=$AUGUR_GITHUB_API_KEY
        echo
    fi

    if [[ -z "${AUGUR_GITHUB_USERNAME}" ]]; then
        get_github_username
    else
        echo
        echo "Found AUGUR_GITHUB_USERNAME environment variable"
        echo "Using it in the config"
        echo "Please unset AUGUR_GITHUB_USERNAME if you would like to be prompted for a github username"
        github_username=$AUGUR_GITHUB_USERNAME
        echo
    fi

    if [[ -z "${AUGUR_FACADE_REPO_DIRECTORY}" ]]; then
        get_facade_repo_path
    else
        echo
        echo "Found AUGUR_FACADE_REPO_DIRECTORY environment variable with value $AUGUR_FACADE_REPO_DIRECTORY"
        echo "Using it in the config"
        echo "IMPORTANT NOTE: This assumes that this directory already exists"
        echo "Please unset AUGUR_FACADE_REPO_DIRECTORY if you would like to be prompted for the facade repo directory"
        facade_repo_directory=$AUGUR_FACADE_REPO_DIRECTORY
        echo
    fi

    if [[ -z "${RABBITMQ_CONN_STRING}" ]]; then
        get_rabbitmq_broker_url
    else
        echo
        echo "Found RABBITMQ_CONN_STRING environment variable with value $RABBITMQ_CONN_STRING"
        echo "Using it in the config"
        echo "Please unset RABBITMQ_CONN_STRING if you would like to be prompted for the rabbit MQ connection string"
        rabbitmq_conn_string=$RABBITMQ_CONN_STRING
        echo
    fi

    # echo $rabbitmq_conn_string
    # echo $facade_repo_directory
    # echo $gitlab_username
    # echo $gitlab_api_key
    # echo $github_username
    # echo $github_api_key

    #special case for docker entrypoint
    if [ $target = "docker" ]; then
      cmd=( collectoss config init --github-api-key $github_api_key --gitlab-api-key $gitlab_api_key --facade-repo-directory $facade_repo_directory --redis-conn-string $redis_conn_string --rabbitmq-conn-string $rabbitmq_conn_string --logs-directory /logs)
      echo "init with redis $redis_conn_string"
    else
      cmd=( collectoss config init --github-api-key $github_api_key --gitlab-api-key $gitlab_api_key --facade-repo-directory $facade_repo_directory --rabbitmq-conn-string $rabbitmq_conn_string )
    fi
    "${cmd[@]}"
}
echo
echo "Collecting data for config..."
create_config
echo
echo "Config created"
echo

# config_prompt
