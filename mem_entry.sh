#!/bin/bash

function mem_entry_load() {
    module_import `realpath utils.sh`
    module_import `realpath mem/mem_recorder.sh`
    MODULE_MEM_LOADED=true
}

function mem_entry_exit() {
    mem_recorder_exit
    unset MODULE_MEM_LOADED
}

if [[ "$MODULE_MEM_LOADED" != 'true' ]]; then
    echo "Loading mem"
    mem_entry_load
fi

