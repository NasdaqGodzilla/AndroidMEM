# AndroidMEM

A adb shell script that collect Android memory usage

# Feature

Collect memory Usage(Memory Free/Memory Avai) via /proc/meminfo

Output example:

```
mem_recorder_test: memfree: 827536 KiB(808 MB/0 GB)
mem_recorder_test: memavai: 3379976 KiB(3300 MB/3 GB)
mem_recorder_test: free-avai:  826772 3379212 807 3299
```

# Usage

```
adb push * /data/local/tmp
source utils.sh mem_recorder.sh
mem_recorder_test
```
# Feature

Collect top memory usage and draws to pie chart

Usage(Get top 10 mem usage and draws to pie chart):

```
top -bq -o %MEM,ARGS -s1 -n1 -m10 | OUTPUT_SVG_W=400 OUTPUT_SVG_H=680  source pie > pie.svg
```

OUTPUT_SVG_W, OUTPUT_SVG_H: Set output svg file size

Output Example:

![](https://cdn.jsdelivr.net/gh/NasdaqGodzilla/PeacePicture/img/pie_example_output.svg)

