#!/bin/bash -e

yarn

projects=`ls -d */ | sed 's/.$//' | awk '!/node_modules/ && !/common/'`

for project in $projects
do
  cd $project
  yarn
  cd ..
done
