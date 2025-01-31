#!/bin/bash

dictionary="$HOME/tbyoung244/data/dictionary.txt"
output_file="coins.txt"

kfcminer() {
    for word in $(cat $dictionary); do
        if [[ $word =~ ^[a-zA-Z]+$ ]]; then
            for nonce in $(seq 10 1000); do
                input="${nonce}${word}"
                hash=$(echo -n "$input" | sha256sum | cut -d ' ' -f1)
                if [[ $hash == 000* ]]; then
                    echo "$input" >> "$output_file"
                fi
            done
        fi
    done
}

kfcminer

echo "Done"

