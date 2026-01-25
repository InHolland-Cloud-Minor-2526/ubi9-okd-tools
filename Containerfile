FROM registry.access.redhat.com/ubi9-minimal:9.7-1768783948@sha256:90bd85dcd061d1ad6dbda70a867c41958c04a86462d05c631f8205e8870f28f8 AS build

RUN microdnf install -y gzip tar && microdnf clean all

ADD download-and-verify-tools.sh .
RUN ./download-and-verify-tools.sh

FROM registry.access.redhat.com/ubi9-minimal:9.7-1768783948@sha256:90bd85dcd061d1ad6dbda70a867c41958c04a86462d05c631f8205e8870f28f8

LABEL org.opencontainers.image.source="https://github.com/InHolland-Cloud-Minor-2526/ubi9-okd-tools" \
      org.opencontainers.image.description="Let's run a okd oc client in a container"

RUN microdnf install -y procps-ng && microdnf clean all

COPY --from=build /usr/local/bin/* /usr/local/bin/
COPY kubeconform /usr/local/share/kubeconform/
