#!/bin/bash
set -e
shopt -s expand_aliases
source ~/.bashrc

function get_old_releases() {
  s3 ls "s3://${AWS_BUCKET}" | awk '{ print $2 }' | sort --version-sort | head -n -${MAX_COUNT}
}

# clean old releases
echo "Keep the last ${MAX_COUNT} releases"
echo 'Detecting old releases...'

for build in $(get_old_releases)
do
  echo '-----------------------------'
  echo "=> Removing old release: ${build}"
  s3 rm --recursive "s3://${AWS_BUCKET}/${build}"
  echo
done

echo '-----------------------------'
echo 'Available releases:'
s3 ls "s3://${AWS_BUCKET}"

echo '-----------------------------'
echo 'Cleaned successfully!'
echo '-----------------------------'
