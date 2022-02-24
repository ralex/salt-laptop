{% if salt['pillar.get']('github.com:token') is defined %}
{% set curl_header = '-H "Authorization: token '~ salt['pillar.get']('github.com:token') ~'"' %}
{% else %}
{% set curl_header = '' %}
{% endif %}

deb [arch=amd64] https://apt.releases.hashicorp.com bullseye main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/terraform.list
    - key_url: https://apt.releases.hashicorp.com/gpg

terraform:
  pkg.installed

{% set version = salt['pillar.get']('terraform:terraformer:version', salt['cmd.run']('curl '~ curl_header ~' -sL "https://api.github.com/repos/GoogleCloudPlatform/terraformer/releases/latest" | jq -r ".tag_name"', python_shell=True)) %}
{% set provider = salt['pillar.get']('terraform:terraformer:provider', 'all') %}
/usr/local/bin/terraformer:
  file.managed:
    - source: https://github.com/GoogleCloudPlatform/terraformer/releases/download/{{ version }}/terraformer-{{ provider }}-linux-amd64
    - skip_verify: True
    - makedirs: True
    - mode: '0755'

{% set version = salt['pillar.get']('terraform:terragrunt:version', salt['cmd.run']('curl '~ curl_header ~' -sL "https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest" | jq -r ".tag_name"', python_shell=True)) %}
/usr/local/bin/terragrunt:
  file.managed:
    - source: https://github.com/gruntwork-io/terragrunt/releases/download/{{ version }}/terragrunt_linux_amd64
    - source_hash: https://github.com/gruntwork-io/terragrunt/releases/download/{{ version }}/SHA256SUMS
    - makedirs: True
    - mode: '0755'

{% set version = salt['pillar.get']('terraform:terraform-docs:version', salt['cmd.run']('curl '~ curl_header ~' -sL "https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest" | jq -r ".tag_name"', python_shell=True)) %}
/usr/local/bin/terraform-docs-salt:
  archive.extracted:
    - source: https://github.com/terraform-docs/terraform-docs/releases/download/{{ version }}/terraform-docs-{{ version }}-linux-amd64.tar.gz
    - source_hash: https://github.com/terraform-docs/terraform-docs/releases/download/{{ version }}/terraform-docs-{{ version }}.sha256sum
    - enforce_toplevel: False
    - makedirs: True
    - mode: '0755'
    - user: root
    - group: root

/usr/local/bin/terraform-docs-salt/terraform-docs:
  file.symlink:
    - target: /usr/local/bin/terraform-docs

{% set version = salt['pillar.get']('terraform:tfsec:version', salt['cmd.run']('curl '~ curl_header ~' -sL "https://api.github.com/repos/tfsec/tfsec/releases/latest" | jq -r ".tag_name"', python_shell=True)) %}
/usr/local/bin/tfsec:
  file.managed:
    - source: https://github.com/tfsec/tfsec/releases/download/{{ version }}/tfsec-linux-amd64
    - skip_verify: True
    - makedirs: True
    - mode: '0755'

deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli bullseye main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/azure-cli.list
    - key_url: https://packages.microsoft.com/keys/microsoft.asc

azure-cli:
  pkg.installed
