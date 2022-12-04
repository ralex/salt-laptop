{% if salt['pillar.get']('github.com:token') is defined %}
{% set curl_header = '-H "Authorization: token '~ salt['pillar.get']('github.com:token') ~'"' %}
{% else %}
{% set curl_header = '' %}
{% endif %}

deb [signed-by=/etc/apt/trusted.gpg.d/terraform.gpg arch=amd64] https://apt.releases.hashicorp.com bullseye main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/terraform.list
    - key_url: https://apt.releases.hashicorp.com/gpg
    - aptkey: False

terraform:
  pkg.installed

{% if salt['pillar.get']('terraform:terraformer:version') is defined %}
{% set terraformer_version = salt['pillar.get']('terraform:terraformer:version', salt['cmd.run']('curl '~ curl_header ~' -sL "https://api.github.com/repos/GoogleCloudPlatform/terraformer/releases/latest" | jq -r ".tag_name"', python_shell=True)) %}
{% endif %}
{% if terraformer_version is not defined %}
{% set terraformer_version = '0.8.22' %}
{% endif %}
{% set provider = salt['pillar.get']('terraform:terraformer:provider', 'all') %}
/usr/local/bin/terraformer:
  file.managed:
    - source: https://github.com/GoogleCloudPlatform/terraformer/releases/download/{{ terraformer_version }}/terraformer-{{ provider }}-linux-amd64
    - skip_verify: True
    - makedirs: True
    - mode: '0755'

{% if salt['pillar.get']('terraform:terragrunt:version') is defined %}
{% set terragrunt_version = salt['pillar.get']('terraform:terragrunt:version', salt['cmd.run']('curl '~ curl_header ~' -sL "https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest" | jq -r ".tag_name"', python_shell=True)) %}
{% endif %}
{% if terragrunt_version is not defined %}
{% set terragrunt_version = 'v0.42.3' %}
{% endif %}
/usr/local/bin/terragrunt:
  file.managed:
    - source: https://github.com/gruntwork-io/terragrunt/releases/download/{{ terragrunt_version }}/terragrunt_linux_amd64
    - source_hash: https://github.com/gruntwork-io/terragrunt/releases/download/{{ terragrunt_version }}/SHA256SUMS
    - makedirs: True
    - mode: '0755'

{% if salt['pillar.get']('terraform:terraform-docs:version') is defined %}
{% set terraform_docs_version = salt['pillar.get']('terraform:terraform-docs:version', salt['cmd.run']('curl '~ curl_header ~' -sL "https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest" | jq -r ".tag_name"', python_shell=True)) %}
{% endif %}
{% if terraform_docs_version is not defined %}
{% set terraform_docs_version = 'v0.16.0' %}
{% endif %}
/usr/local/bin/terraform-docs-salt:
  archive.extracted:
    - source: https://github.com/terraform-docs/terraform-docs/releases/download/{{ terraform_docs_version }}/terraform-docs-{{ terraform_docs_version }}-linux-amd64.tar.gz
    - source_hash: https://github.com/terraform-docs/terraform-docs/releases/download/{{ terraform_docs_version }}/terraform-docs-{{ terraform_docs_version }}.sha256sum
    - enforce_toplevel: False
    - makedirs: True
    - mode: '0755'
    - user: root
    - group: root

/usr/local/bin/terraform-docs:
  file.symlink:
    - target: /usr/local/bin/terraform-docs-salt/terraform-docs


{% if salt['pillar.get']('terraform:tfsec:version') is defined %}
{% set tfsec_version = salt['pillar.get']('terraform:tfsec:version', salt['cmd.run']('curl '~ curl_header ~' -sL "https://api.github.com/repos/tfsec/tfsec/releases/latest" | jq -r ".tag_name"', python_shell=True)) %}
{% endif %}
{% if tfsec_version is not defined %}
{% set tfsec_version = 'v1.28.1' %}
{% endif %}
/usr/local/bin/tfsec:
  file.managed:
    - source: https://github.com/tfsec/tfsec/releases/download/{{ tfsec_version }}/tfsec-linux-amd64
    - source_hash: https://github.com/tfsec/tfsec/releases/download/{{ tfsec_version }}/tfsec_checksums.txt
    - makedirs: True
    - mode: '0755'

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/microsoft-keyring.gpg:
  cmd.run:
    - unless: test -f /usr/share/keyrings/microsoft-keyring.gpg

deb [signed-by=/usr/share/keyrings/microsoft-keyring.gpg arch=amd64] https://packages.microsoft.com/repos/azure-cli bullseye main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/azure-cli.list

azure-cli:
  pkg.installed
