#!/bin/bash

wget http://pages.stat.wisc.edu/~jgillett/679/CHTC/wordCounting/shakespeare.tar
tar xvf shakespeare.tar

dirs=$(ls -d shakespeare/*/)
mkdir allplays
for dir in $dirs;
do
  for file in $(ls $dir);
  do 
    cp $dir/$file allplays
  done
done

cat allplays/* > plays.txt
rm -r allplays

nProcessors=5
data="plays.txt"
nDataLines=$(wc -l < $data)
nLinesPerSplitFile=$(($nDataLines / $nProcessors))
remainder=$(($nDataLines % $nProcessors))
if [[ $remainder > 0 ]]; then
  nLinesPerSplitFile=$(($nLinesPerSplitFile + 1))
fi
split -d -l $nLinesPerSplitFile $data "$data."