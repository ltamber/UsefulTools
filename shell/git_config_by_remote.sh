#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 \"Name\" \"Email\" \"URL_FILTER\""
    exit 1
fi
user_name=$1
user_email=$2
url_filter=$3
for repo in ./*
do
    if [ -d $repo ]; then
        cd $repo
        if [ -d ".git" ]; then
            echo "Found new repo directory:$repo"
            matched=`grep -i $url_filter .git/config | grep "url" | grep -v grep | wc -l`
            if [[ matched -gt 0 ]]; then
                git config user.name "$user_name"
                git config user.email "$user_email"
                echo "$repo config done"
            fi
        fi
        cd ../
    fi
done
