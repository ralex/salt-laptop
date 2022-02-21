deb [arch=amd64] https://apt.releases.hashicorp.com bullseye main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/terraform.list
    - key_url: https://apt.releases.hashicorp.com/gpg

terraform:
  pkg.installed

{% set version = salt['pillar.get']('terraform:terraformer:version', salt['cmd.run']('curl -sL "https://api.github.com/repos/GoogleCloudPlatform/terraformer/releases/latest" | jq -r ".tag_name"', python_shell=True)) %}
{% set provider = salt['pillar.get']('terraform:terraformer:provider', 'all') %}
/usr/local/bin/terraformer:
  file.managed:
    - source: https://github.com/GoogleCloudPlatform/terraformer/releases/download/{{ version }}/terraformer-{{ provider }}-linux-amd64
    - skip_verify: True
    - makedirs: True
    - mode: '0755'

{% set version = salt['pillar.get']('terraform:terragrunt:version', salt['cmd.run']('curl -sL "https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest" | jq -r ".tag_name"', python_shell=True)) %}
/usr/local/bin/terragrunt:
  file.managed:
    - source: https://github.com/gruntwork-io/terragrunt/releases/download/v{{ version }}/terragrunt_linux_amd64
    - source_hash: https://github.com/gruntwork-io/terragrunt/releases/download/v{{ version }}/SHA256SUMS
    - makedirs: True
    - mode: '0755'

{% set version = salt['pillar.get']('terraform:terraform-docs:version', salt['cmd.run']('curl -sL "https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest" | jq -r ".tag_name"', python_shell=True)) %}
/usr/local/bin/terraform-docs:
  file.managed:
    - source: https://github.com/terraform-docs/terraform-docs/releases/download/v{{ version }}/terraform-docs-v{{ version }}-linux-amd64
    - source_hash: https://github.com/terraform-docs/terraform-docs/releases/download/v{{ version }}/terraform-docs-v{{ version }}.sha256sum
    - makedirs: True
    - mode: '0755'

{% set version = salt['pillar.get']('terraform:tfsec:version', salt['cmd.run']('curl -sL "https://api.github.com/repos/tfsec/tfsec/releases/latest" | jq -r ".tag_name"', python_shell=True)) %}
/usr/local/bin/tfsec:
  file.managed:
    - source: https://github.com/tfsec/tfsec/releases/download/v{{ version }}/tfsec-linux-amd64
    - skip_verify: True
    - makedirs: True
    - mode: '0755'

deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli bullseye main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/azure-cli.list
    - key_url: https://packages.microsoft.com/keys/microsoft.asc

azure-cli:
  pkg.installed
