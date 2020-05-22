curl -Lo ./terraform-docs https://github.com/segmentio/terraform-docs/releases/download/v0.9.1/terraform-docs-v0.9.1-$(uname | tr '[:upper:]' '[:lower:]')-amd64
chmod +x ./terraform-docs
mv ./terraform-docs ${HOME}/bin