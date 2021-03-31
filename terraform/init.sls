deb [arch=amd64] https://apt.releases.hashicorp.com buster main:
  pkgrepo.managed:
    - humanname: Terraform
    - file: /etc/apt/sources.list.d/terraform.list
    - key_url: https://apt.releases.hashicorp.com/gpg

terraform:
  pkg.installed

{% set version = salt['pillar.get']('terraform:terraformer:version', '0.8.9') %}
{% set provider = salt['pillar.get']('terraform:terraformer:provider', 'all') %}
/usr/local/bin/terraformer:
  file.managed:
    - source: https://github.com/GoogleCloudPlatform/terraformer/releases/download/{{ version }}/terraformer-{{ provider }}-linux-amd64
    - skip_verify: True
    - makedirs: True
    - mode: '0755'

{% set version = salt['pillar.get']('terraform:terragrunt:version', '0.25.0') %}
/usr/local/bin/terragrunt:
  file.managed:
    - source: https://github.com/gruntwork-io/terragrunt/releases/download/v{{ version }}/terragrunt_linux_amd64
    - source_hash: https://github.com/gruntwork-io/terragrunt/releases/download/v{{ version }}/SHA256SUMS
    - makedirs: True
    - mode: '0755'

{% set version = salt['pillar.get']('terraform:terraform-docs:version', '0.12.1') %}
/usr/local/bin/terraform-docs:
  file.managed:
    - source: https://github.com/terraform-docs/terraform-docs/releases/download/v{{ version }}/terraform-docs-v{{ version }}-linux-amd64
    - source_hash: https://github.com/terraform-docs/terraform-docs/releases/download/v{{ version }}/terraform-docs-v{{ version }}.sha256sum
    - makedirs: True
    - mode: '0755'

deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ buster main:
  pkgrepo.managed:
    - humanname: Azure cli
    - file: /etc/apt/sources.list.d/azure-cli.list
    - key_url: https://packages.microsoft.com/keys/microsoft.asc

azure-cli:
  pkg.installed
