#!/bin/bash

# unpack R installation
tar -xzf R.tar.gz

# set script to use your R installation
export PATH=$(pwd)/R/bin:$PATH

# get the first 10 spectra
head -10 result.csv > graph.csv

# create comparison plot one by one
filename="graph.csv"
while read p; do
    spectrum=$(echo $p | cut -d ',' -f 2)
    pos=$(echo $p | cut -d ',' -f 3)
    dir=$(echo $spectrum | cut -d '-' -f 1)
    cp /home/groups/stat679/boss/tgz/$dir.tgz $dir.tgz
    tar -xf $dir.tgz
    R CMD BATCH --no-save "--args cb58_Lyman_break.fit $dir $spectrum $pos" graph.R
    rm -r $dir $dir.tgz
done < $filename
