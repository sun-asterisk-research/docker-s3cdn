ARG TAG=2.9.6

FROM amazon/aws-cli:${TAG}

WORKDIR /srv

ENV MAX_COUNT=5
ENV AWS_ENDPOINT=https://s3.amazonaws.com
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/scripts

COPY docker/scripts /scripts

RUN echo 'alias s3="aws s3 --endpoint-url=${AWS_ENDPOINT}"' >> ~/.bashrc \
  && echo 'alias s3api="aws s3api --endpoint-url=${AWS_ENDPOINT}"' >> ~/.bashrc

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "run.sh" ]
