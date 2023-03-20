#!/bin/bash

# echo 123213 byte | utils_human_print
function utils_human_print_byte() {
    while read B dummy; do
        [ $B -lt 1024 ] && echo ${B} bytes && break
        KB=$(((B+512)/1024))
        [ $KB -lt 1024 ] && echo ${KB} KiB && break
        MB=$(((KB+512)/1024))
        [ $MB -lt 1024 ] && echo ${MB} MiB && break
        GB=$(((MB+512)/1024))
        [ $GB -lt 1024 ] && echo ${GB} GiB && break
        echo $(((GB+512)/1024)) TiB
    done
}

function utils_human_print_kb() {
    while read KB dummy; do
        [ $KB -lt 1024 ] && echo ${KB} KiB && break
        MB=$(((KB+512)/1024))
        [ $MB -lt 1024 ] && echo ${MB} MiB && break
        GB=$(((MB+512)/1024))
        [ $GB -lt 1024 ] && echo ${GB} GiB && break
        echo $(((GB+512)/1024)) TiB
    done
}

function utils_kb2mb() {
    local kb="$1"
    echo "$(( ${kb%% *} / 1024)) MB"
}

function utils_mb2gb() {
    local mb="$1"
    echo "$(( ${mb%% *} / 1024)) GB"
}

function utils_load() {
    MODULE_UTILS_LOADED=true
    echo utils_load
}

function utils_exit() {
    unset MODULE_UTILS_LOADED
}

if [[ "$MODULE_UTILS_LOADED" != 'true' ]]; then
        echo "Loading utils"
        utils_load
fi

