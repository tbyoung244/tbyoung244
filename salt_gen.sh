#!/bin/bash

username_list="user_list.txt"
new_file="nonce-data.csv"
salts_file="salts_used.csv"

nonce_creator() {
    echo $((RANDOM % 90000 + 10000))
}

> "$new_file"
> "$salts_file"

while IFS= read -r username; do
    nonce=$(nonce_creator)
    salted_username="${nonce}${username}"
    hash=$(echo -n "$salted_username" | sha256sum | cut -d " " -f1)
    echo "$nonce,$hash" >> "$new_file"
    echo "$nonce,$username" >> "$salts_file"
done < "$username_list"

echo "Done"

