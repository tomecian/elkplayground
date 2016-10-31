#!/bin/bash

username=$1
password=$2
host=$3

for i in `seq 1 5000`; do
        $(wget -O /dev/null --user $1 --password $2 "http://$3")
done