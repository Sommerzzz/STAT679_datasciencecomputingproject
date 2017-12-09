#!/bin/bash
#Usage Calculate mean of comma seperate file
#Time 2017/11/2 STAT679 group work 4
#Author Qizheng Ren
# Give the usage message
# NEVER WRITE ANYTHING BEHIND A VARIABLE
if [[ ($# -ne 1) && ($# -ne 2) ]]; then 
 echo "usage: $0 <column> [file.csv]" 1>&2 
 exit 0
fi
#Get file from stdin first 
file=/dev/stdin
if [[ $# == 2 ]]; then
 file=$2
fi
column=$1
file=$2
data=$( cat $file | awk -v a=$column 'BEGIN {FS=","} NR>=2 {print $a}')
line_num=$( echo $data | wc -w )
#Calculate the mean
sum=0
for i in $data;
 do sum=$( echo "scale=2; $sum+$i" |bc)
done
mean=$(echo "scale=2; $sum/$line_num" |bc)
echo $mean
