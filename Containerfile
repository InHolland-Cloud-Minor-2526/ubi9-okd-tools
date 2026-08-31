FROM registry.access.redhat.com/ubi9-minimal:9.8-1788166357@sha256:7fbeae18dc9476399f565e68255f602a3374ea8614ba3d14843565131a13ff93 AS build

RUN microdnf install -y gzip tar && microdnf clean all

ADD download-and-verify-tools.sh .
RUN ./download-and-verify-tools.sh

FROM registry.access.redhat.com/ubi9-minimal:9.8-1788166357@sha256:7fbeae18dc9476399f565e68255f602a3374ea8614ba3d14843565131a13ff93

LABEL org.opencontainers.image.source="https://github.com/InHolland-Cloud-Minor-2526/ubi9-okd-tools" \
      org.opencontainers.image.description="Let's run a okd oc client in a container"

RUN microdnf install -y procps-ng && microdnf clean all

COPY --from=build /usr/local/bin/* /usr/local/bin/
COPY kubeconform /usr/local/share/kubeconform/
