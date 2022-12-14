# docker-s3-cdn

Websites serving bandwidth-intensive video content, where high latencies and slow loading times directly impact user experience, can benefit greatly from using object storage with a CDN. CDNs reduce page load times, improve performance, and reduce bandwidth and infrastructure costs by caching assets across a set of geographically distributed servers.

`s3cdn` provides the built-in script to do these things:
- Upload your files to the object storage server
- Remove files in the old releases

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
  ghcr.io/sunasteriskrnd/s3cdn:2.9.6
```


