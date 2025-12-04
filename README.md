# ubi9-okd-tools

This image can be used to run the `oc` client in a container. Don't forget to add RoleBindings to the ServiceAccount that will be used to run the container.

### Tools available in the container

* the `oc` client as release by the OKD project
* the `kubeconform` binary from [yannh/kubeconform](https://github.com/yannh/kubeconform/)
* everything from `procps-ng`, like `watch`

For validation of Paas objects with kubeconform, we've also added the Paas CRD's to the image.
