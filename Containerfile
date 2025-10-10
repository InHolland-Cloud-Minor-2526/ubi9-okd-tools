FROM registry.access.redhat.com/ubi9-minimal:9.6-1755695350 AS build

RUN microdnf install -y gzip tar && microdnf clean all

ADD download-and-verify-client.sh .
RUN ./download-and-verify-client.sh

FROM registry.access.redhat.com/ubi9-minimal:9.6-1755695350

LABEL org.opencontainers.image.source="https://github.com/InHolland-Cloud-Minor-2526/ubi9-okd-tools" \
      org.opencontainers.image.description="Let's run a okd oc client in a container"

COPY --from=build /usr/local/bin/* /usr/local/bin/

