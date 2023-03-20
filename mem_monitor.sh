#!/system/bin/sh

MEM_INTERVAL_=1
MEM_RECORD_=1
MEM_RECORD_SILENT_=1

MEM_RECORDS_AVAI_=""
MEM_RECORDS_FREE_=""

MEM_RESULT_AVAI_AVER_=0
MEM_RESULT_AVAI_MIN_=888889999
MEM_RESULT_FREE_AVER_=0
MEM_RESULT_FREE_MIN_=888889999

function mem_monitor_finally() {
    MEM_RESULT_AVAI_AVER_=`echo -e "$MEM_RECORDS_AVAI_" | awk -F' ' \
                '{ cnt+=1; sum+=$1 } \
                END { print sum/cnt} '`
    MEM_RESULT_FREE_AVER_=`echo -e "$MEM_RECORDS_FREE_" | awk -F' ' \
                '{ cnt+=1; sum+=$1 } \
                END { print sum/cnt} '`

    echo MemAvailable records: `echo $MEM_RECORDS_AVAI_ | wc -w`
    echo MemFree records: `echo $MEM_RECORDS_FREE_ | wc -w`

    echo MemAvailable min: $MEM_RESULT_AVAI_MIN_
    echo MemAvailable aver: $MEM_RESULT_AVAI_AVER_
    echo MemFree min: $MEM_RESULT_FREE_MIN_
    echo MemFree aver: $MEM_RESULT_FREE_AVER_
}

function mem_monitor_trap_handler() {
    MEM_RECORD_=0
}

trap mem_monitor_trap_handler 2 3 6 9 15

while [[ "$MEM_RECORD_" == "1" ]]; do
    meminfo_=`cat /proc/meminfo`

    meminfo_memavai_=`echo -e "$meminfo_" | awk '/MemAvailable/{print $2}'`
    meminfo_memfree_=`echo -e "$meminfo_" | awk '/MemFree/{print $2}'`

    if [[ "$meminfo_memavai_" -lt "$MEM_RESULT_AVAI_MIN_" ]]; then
        MEM_RESULT_AVAI_MIN_="$meminfo_memavai_"
    fi

    if [[ "$meminfo_memfree_" -lt "$MEM_RESULT_FREE_MIN_" ]]; then
        MEM_RESULT_FREE_MIN_="$meminfo_memfree_"
    fi

    MEM_RECORDS_AVAI_=$MEM_RECORDS_AVAI_" "$meminfo_memavai_
    MEM_RECORDS_FREE_=$MEM_RECORDS_FREE_" "$meminfo_memfree_

    if [[ "$MEM_RECORD_SILENT_" -ne "1" ]]; then
        echo $meminfo_memavai_" "$meminfo_memfree_
    fi

    sleep $MEM_INTERVAL_
done

mem_monitor_finally

