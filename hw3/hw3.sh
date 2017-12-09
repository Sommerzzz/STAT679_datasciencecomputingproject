#!/bin/bash

# unpack R installation
tar -xzf R.tar.gz

# set script to use your R installation
export PATH=$(pwd)/R/bin:$PATH

# unpack tgz
tar -xvf $2.tgz

# run R, with the name of your R script
R CMD BATCH --no-save "--args $1 $2" hw3.R

# remove tgz
rm -r $2.tgz $2 R