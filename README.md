# docker-s3cdn

Websites serving bandwidth-intensive video content, where high latencies and slow loading times directly impact user experience, can benefit greatly from using object storage with a CDN. CDNs reduce page load times, improve performance, and reduce bandwidth and infrastructure costs by caching assets across a set of geographically distributed servers.

This is a Docker image for the AWS CLI. It called `s3cdn` that provides the built-in script to do these things:
1. Release your new files (js, css, images...) to S3. For example: `release-1`, `release-2`, `release-3`
```bash
> s3 ls s3://cdn
        PRE release-1/
        PRE release-2/
        PRE release-3/
        PRE release-4/
        PRE release-5/
        PRE release-6/
        PRE release-7/
```

2. Remove the old releases (ex: you want to keep the last 5 releases in S3). For example, the last 5 releases will be:
```bash
> s3 ls s3://cdn
        PRE release-3/
        PRE release-4/
        PRE release-5/
        PRE release-6/
        PRE release-7/
```

3. Provide bash aliases for S3 (Please use `/bin/bash`):
```
s3 -> aws s3 --endpoint-url $AWS_ENDPOINT
s3api -> aws s3api --endpoint-url $AWS_ENDPOINT
```

## Usage

All-in-one:

```
docker run --rm \
  -e AWS_ACCESS_KEY_ID=your-id \
  -e AWS_SECRET_ACCESS_KEY=your-secret-key \
  -e AWS_BUCKET=your-bucket-label \
  -e AWS_REGION=your-region \
  -e AWS_ENDPOINT=your-custom-endpoint \
  -e MAX_COUNT=5 \
  -e SOURCE_DIR=public/dist \
  -e TARGET_DIR=build-01 \
  ghcr.io/sun-asterisk-rnd/s3cdn:2.9.6
```

### Environment variables

| Name | Description |Default |
| -------- | -------- | -------- |
| AWS_ACCESS_KEY_ID     | The access key     |     |
| AWS_SECRET_ACCESS_KEY     | The secret of the access key    |     |
| AWS_BUCKET     | The bucket label     |     |
| AWS_REGION     | The region ID    |     |
| AWS_ENDPOINT     | The endpoint URL     | https://s3.amazonaws.com     |
| SOURCE_DIR     | The source folder will upload to S3     |      |
| TARGET_DIR     | The destination folder in S3     |     |
| MAX_COUNT     | The number of the last releases will be keep in S3     | 5     |

## Develop

- Run containers:
```bash
cp .env.example .env
docker compose up -d
```

- Access the container then run the script that you want to test. For example:
```bash
docker exec -it s3-cdn_client_1 bash
```
```bash
./docker/scripts/upload.sh
```

- Build docker images:
```bash
# Build all versions
make all

# Build a version:
make 2.9.6
```

- Push docker images to registry:
```bash
# push all images:
make push

# push an image:
make push-2.9.6
```
