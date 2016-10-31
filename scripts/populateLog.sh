#!/bin/bash

username=$1
password=$2
host=$3

for i in `seq 1 5000`; do
        $(wget -O /dev/null -o /dev/null -nv "http://$1:$2@$3")
done