#!/usr/bin/env bash
echo "enter path"
read myfilepath

outy=$(cat $myfilepath)

mydir=$(dirname $myfilepath)

echo -e "$mydir"

echo "$outy"