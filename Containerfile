FROM registry.access.redhat.com/ubi9-minimal:9.8-1791279563@sha256:5ed244b62bbf4095080144d9d35eb8fcd3d39a9801f94aadd63b9d10978a01ae AS build

RUN microdnf install -y gzip tar && microdnf clean all

ADD download-and-verify-tools.sh .
RUN ./download-and-verify-tools.sh

FROM registry.access.redhat.com/ubi9-minimal:9.8-1791279563@sha256:5ed244b62bbf4095080144d9d35eb8fcd3d39a9801f94aadd63b9d10978a01ae

LABEL org.opencontainers.image.source="https://github.com/InHolland-Cloud-Minor-2526/ubi9-okd-tools" \
      org.opencontainers.image.description="Let's run a okd oc client in a container"

RUN microdnf install -y procps-ng && microdnf clean all

COPY --from=build /usr/local/bin/* /usr/local/bin/
COPY kubeconform /usr/local/share/kubeconform/
