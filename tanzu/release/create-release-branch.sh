#!/bin/bash -e

# Usage: create-release-branch.sh v1.1.3 release-v1.1.3

release=$1
target=$2
#release_regexp="^release-([0-9]+\.)+([0-9])$"

#if [[ ! $target =~ $release_regexp ]]; then
#    echo "\"$target\" is wrong format. Must have proper format like release-v1.1.3"
#    exit 1
#fi

# Fetch the latest tags and checkout a new branch from the wanted tag.
git fetch upstream --tags
git checkout -b "$target" "$release"

# Update openshift's main and take all needed files from there.
git fetch tanzu main
#git checkout tanzu/main -- tanzu OWNERS_ALIASES OWNERS Makefile
git checkout tanzu/main -- tanzu Makefile
#make generate-dockerfiles
#make RELEASE=$release generate-release
#make RELEASE=ci generate-release
#git add openshift OWNERS_ALIASES OWNERS Makefile
git add tanzu Makefile
git commit -m "Add tanzu release manifests"
