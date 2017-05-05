#!/bin/bash

case "$1" in
    start)
        sudo ifconfig lo0 alias 192.168.99.99
        docker-compose up
        ;;
    stop)
        docker-compose down
        ;;
    restart)
        docker-compose down
        docker-compose up
        ;;
    *)
        echo $"Usage: $0 {start|stop|restart}"
        exit 1
esac

