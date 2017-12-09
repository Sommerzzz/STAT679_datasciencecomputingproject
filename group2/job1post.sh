#!/bin/bash

sort -m reformatPlays.txt.* -o largeSortedFile.txt
uniq -c largeSortedFile.txt | sort -n -o countOfWords