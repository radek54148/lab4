#!/bin/bash

function display_date {
    echo "Dzisiejsza data: $(date)"
}

function create_logs {
    local num_files=${1:-100}
    mkdir -p logs
    for ((i=1; i<=num_files; i++))
    do
        echo "log$i.txt" > logs/log$i.txt
        echo "Nazwa skryptu: $0" >> logs/log$i.txt
        echo "Data: $(date)" >> logs/log$i.txt
    done
}

function display_help {
    echo "Dostępne opcje:"
    echo "--date | -d: Wyświetla dzisiejszą datę"
    echo "--logs | -l [liczba]: Tworzy pliki logów"
    echo "--help | -h: Wyświetla dostępne opcje"
    echo "--init: Klonuje repozytorium"
    echo "--error | -e [liczba]: Tworzy pliki błędów"
}

function init_repo {
    git clone <URL_REPO> $(pwd)
    export PATH=$(pwd):$PATH
}

function create_errors {
    local num_files=${1:-100}
    mkdir -p errors
    for ((i=1; i<=num_files; i++))
    do
        mkdir -p errors/error$i
        echo "error$i.txt" > errors/error$i/error$i.txt
        echo "Nazwa skryptu: $0" >> errors/error$i/error$i.txt
        echo "Data: $(date)" >> errors/error$i/error$i.txt
    done
}

case "$1" in
    --date|-d)
        display_date
        ;;
    --logs|-l)
        create_logs "$2"
        ;;
    --help|-h)
        display_help
        ;;
    --init)
        init_repo
        ;;
    --error|-e)
        create_errors "$2"
        ;;
    *)
        echo "Nieznana opcja: $1"
        display_help
        ;;
esac
