#!/bin/bash

tr "\t" " " | sed -e s/" "" "*/"\n"/g | sort