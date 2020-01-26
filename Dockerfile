FROM alpine:3.10 as builder

# Note: Latest stable version of nsq may be found at:
# https://nsq.io/deployment/installing.html
ENV NSQ_LATEST_STABLE_VERSION="1.2.0"
ENV NSQ_GOLANG_VERSION="1.12.9"

RUN apk add --no-cache ca-certificates \
    && wget -q https://github.com/nsqio/nsq/releases/download/v${NSQ_LATEST_STABLE_VERSION}/nsq-${NSQ_LATEST_STABLE_VERSION}.linux-amd64.go${NSQ_GOLANG_VERSION}.tar.gz -O nsq.tar.gz \
    && mkdir /nsq \
    && tar -xzf nsq.tar.gz -C /nsq --strip-components=1 \
    && chmod -R +x /nsq/bin

FROM alpine:3.10

ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="nsq-to-x" \
      org.label-schema.url="https://hub.docker.com/r/mirzakhani/nsq-to-x/" \
      org.label-schema.vcs-url="https://github.com/mirzakhany/nsq-to-x" \
      org.label-schema.build-date=$BUILD_DATE

COPY --from=builder /nsq/bin/nsq_to_nsq  /usr/local/bin/
COPY --from=builder /nsq/bin/nsq_to_http /usr/local/bin/
COPY --from=builder /nsq/bin/nsq_to_file /usr/local/bin/
COPY --from=builder /nsq/bin/nsq_tail    /usr/local/bin/
COPY --from=builder /nsq/bin/to_nsq      /usr/local/bin/

CMD nsq_tail
