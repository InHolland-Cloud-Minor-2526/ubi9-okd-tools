#!/bin/sh

set -e

# Download oc client
VERSION="4.19.0-okd-scos.19"
BASE="https://github.com/okd-project/okd/releases/download/$VERSION/"

for file in openshift-client-linux-amd64-rhel9-$VERSION.tar.gz sha256sum.txt sha256sum.txt.asc
do
  curl -OL $BASE/$file
done

curl https://okd.io/okd-maintainers2.pub | gpg --import
gpg --verify sha256sum.txt.asc sha256sum.txt

# Verify downloads
sha256sum --check --ignore-missing sha256sum.txt

# Extract oc client
tar zxf openshift-client-linux-amd64-rhel9-$VERSION.tar.gz && mv oc kubectl /usr/local/bin/

# Download Kubeconform
BASE="https://github.com/yannh/kubeconform/releases/download/v0.7.0"

for file in CHECKSUMS kubeconform-linux-amd64.tar.gz
do
  curl -OL $BASE/$file
done

# Verify downloads
sha256sum --check --ignore-missing CHECKSUMS

tar zxf kubeconform-linux-amd64.tar.gz && mv kubeconform /usr/local/bin/
