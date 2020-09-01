deb [arch=amd64] https://apt.releases.hashicorp.com bullseye main:
  pkgrepo.managed:
    - humanname: Terraform
    - file: /etc/apt/sources.list.d/terraform.list
    - key_url: https://apt.releases.hashicorp.com/gpg

terraform:
  pkg.installed
