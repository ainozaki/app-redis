#!/bin/bash
n=0
while [ "$n" -lt 10 ]
do
	ret=$(memtier_benchmark --ratio 1:1 -t 4 -c 10 -n 10 --hide-histogram -s 172.44.0.2 2> /dev/null)
	echo "$ret" | awk '$1 == "Sets" {print $5 "," $7}'
done
