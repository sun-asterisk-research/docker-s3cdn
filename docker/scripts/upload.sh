#!/bin/bash
set -e

if [ -z "$1" ];
then
  target_dir=$TARGET_DIR
else
  target_dir=$1
fi

# upload new files
echo "Uploading files to s3://${AWS_BUCKET}/${target_dir}"
echo '-----------------------------'
aws s3 sync \
  --endpoint-url "${AWS_ENDPOINT}" \
  --acl public-read \
  "${SOURCE_DIR}" "s3://${AWS_BUCKET}/${target_dir}"
echo '-----------------------------'
echo 'Uploaded successfully!'
echo '-----------------------------'
