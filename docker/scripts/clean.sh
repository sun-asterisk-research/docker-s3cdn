#!/bin/bash
set -e
shopt -s expand_aliases
source ~/.bashrc

if [ -z "$1" ]; then
  target_dir=$TARGET_DIR
else
  target_dir=$1
fi

target_dir=$(echo $target_dir | awk '{gsub(/^[\/ ]+|[\/ ]+$/,"")} {print $0 }')
parent_dir=$(dirname $target_dir)

if [[ $parent_dir == "." ]]; then
  root_dir="s3://${AWS_BUCKET}"
else
  root_dir="s3://${AWS_BUCKET}/${parent_dir}"
fi

function get_old_releases() {
  s3 ls "${root_dir}/" | awk '{ print $2 }' | sort --version-sort | head -n -${MAX_COUNT}
}

# clean old releases
echo "Keep the last ${MAX_COUNT} releases"
echo 'Detecting old releases...'

for build in $(get_old_releases)
do
  echo '-----------------------------'
  echo "=> Removing old release: ${root_dir}/${build}"
  s3 rm --recursive "${root_dir}/${build}"
  echo
done

echo '-----------------------------'
echo 'Available releases:'
s3 ls "${root_dir}/"

echo '-----------------------------'
echo 'Cleaned successfully!'
echo '-----------------------------'
