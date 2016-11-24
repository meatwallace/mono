#!/bin/bash -e

detect_changed_projects() {
  echo "Build: detecting changes for this build"

  # Grab all projects, filter our .build and all non-directories
  projects=` \
    git diff --name-only $TRAVIS_COMMIT_RANGE | \
    sort -u | \
    awk 'BEGIN {FS="/"} {print $1}' | \
    awk '{if(system("[ -d " $1 " ]") == 0) {print $1}}' | \
    awk '!/.build/' | \
    uniq`

  # Determine if common code changed
  common_changed=false
  for project in $projects
  do
    if [ "$project" == "common" ]; then
      common_changed=true
      break
    fi
  done

  if [ "$common_changed" == true ]; then
    echo "Build: common changed, building all projects"
    export changed_projects=`ls -d */ | sed 's/.$//' | awk '!/node_modules/ && !/common/'`
  else
    export changed_projects=$projects
  fi
}

build_changed_projects() {
  for project in $changed_projects
  do
    build_project $project
  done
}

build_project() {
  if [[ -z "$1" ]]; then
    return 0
  elif cat "$1/package.json" | jq -r '.scripts' | jq -e 'has("build")' > /dev/null; then
    cd $1
    npm run build
    cd ..
  fi
}

if [ "$TRAVIS_PULL_REQUEST" != true ]; then
  detect_changed_projects
  build_changed_projects
else
  echo "Build: pull request detected, skipping build"
fi
