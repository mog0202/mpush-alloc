FROM openjdk:8-jre-slim

ENV MPUSH_ALLOC_HOME /mpush-alloc
ENV MPUSH_ALLOC_VERSION 0.8.0
EXPOSE 9999

WORKDIR /

RUN set -x \
    && apt-get update && DEBIAN_FRONTEND=nointeractive apt-get install -y --no-install-recommends \
       wget ;\
       rm -rf /var/lib/apt/lists/* \
    && wget -O /tmp/alloc-release-${MPUSH_ALLOC_VERSION}.tar.gz \
       "https://github.com/mpusher/alloc/releases/download/v${MPUSH_ALLOC_VERSION}/alloc-release-${MPUSH_ALLOC_VERSION}.tar.gz" \
    && tar zxf /tmp/alloc-release-${MPUSH_ALLOC_VERSION}.tar.gz  \
    && mv mpush-alloc-${MPUSH_ALLOC_VERSION} ${MPUSH_ALLOC_HOME} \
    && chmod +x ${MPUSH_ALLOC_HOME}/bin/*.sh \
    && rm /tmp/alloc-release-${MPUSH_ALLOC_VERSION}.tar.gz

VOLUME "${MPUSH_ALLOC_HOME}"
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
