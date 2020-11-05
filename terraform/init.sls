deb [arch=amd64] https://apt.releases.hashicorp.com buster main:
  pkgrepo.managed:
    - humanname: Terraform
    - file: /etc/apt/sources.list.d/terraform.list
    - key_url: https://apt.releases.hashicorp.com/gpg

terraform:
  pkg.installed

{% set version = salt['pillar.get']('terraform:terraformer:provider', '0.8.9') %}
{% set provider = salt['pillar.get']('terraform:terraformer:provider', 'all') %}
/usr/local/bin/terraformer:
  file.managed:
    - source: https://github.com/GoogleCloudPlatform/terraformer/releases/download/{{ version }}/terraformer-{{ provider }}-linux-amd64
    - skip_verify: True
    - makedirs: True
    - mode: '0755'
