#!/bin/bash

function mem_recorder_load() {
    echo mem_recorder_load
}

function mem_recorder_exit() {
    echo mem_recorder_exit
}

function mem_recorder_get_meminfo() {
    cat /proc/meminfo
}

# Get free mem from input meminfo, in kB
function mem_recorder_get_memfree() {
    local meminfo="$1"
    echo `echo -e "$meminfo" | awk '/MemFree/{print $2}'`
}

# Get available mem from input meminfo, in kB
function mem_recorder_get_memavai() {
    local meminfo="$1"
    echo `echo -e "$meminfo" | awk '/MemAvailable/{print $2}'`
}

function mem_recorder_print() {
    local request="$1"
    local meminfo="$(echo -e "`mem_recorder_get_meminfo`")"
    local memfree=`eval "mem_recorder_get_memfree \"echo $meminfo\""`
    local memavai=`eval "mem_recorder_get_memavai \"echo $meminfo\""`

    if [[ "$request" == 'kB' ]]; then
        echo $memfree $memavai
        return
    fi

    local memfree_mb=`utils_kb2mb $memfree`
    local memavai_mb=`utils_kb2mb $memavai`

    echo $memfree_mb $memavai_mb
}

function mem_recorder_test() {
    local meminfo="$(echo -e "`mem_recorder_get_meminfo`")"

    local memfree=`eval "mem_recorder_get_memfree \"echo $meminfo\""`
    local memfree_mb=`utils_kb2mb $memfree`
    local memfree_gb=`utils_mb2gb $memfree_mb`
    local memavai=`eval "mem_recorder_get_memavai \"echo $meminfo\""`
    local memavai_mb=`utils_kb2mb $memavai`
    local memavai_gb=`utils_mb2gb $memavai_mb`

    echo "mem_recorder_test: meminfo:"
    echo -e "$meminfo"
    echo "mem_recorder_test: memfree: $memfree KiB($memfree_mb MB/$memfree_gb GB)"
    echo "mem_recorder_test: memavai: $memavai KiB($memavai_mb MB/$memavai_gb GB)"
    echo "mem_recorder_test: free-avai: " `mem_recorder_print kB` `mem_recorder_print`
}

mem_recorder_load

