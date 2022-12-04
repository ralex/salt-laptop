{% if salt['pillar.get']('github.com:token') is defined %}
{% set curl_header = '-H "Authorization: token '~ salt['pillar.get']('github.com:token') ~'"' %}
{% else %}
{% set curl_header = '' %}
{% endif %}
{% if salt['pillar.get']('cura:version') is defined %}
{% set cura_version = salt['pillar.get']('cura:version', salt['cmd.run']('curl '~ curl_header ~' -sL "https://api.github.com/repos/Ultimaker/Cura/releases/latest" | jq -r ".tag_name"', python_shell=True)) %}
{% endif %}
{% if cura_version is not defined %}
{% set cura_version = 'v0.16.0' %}1
{% endif %}

/opt/cura/Ultimaker_Cura.AppImage:
  file.managed:
    - source: https://github.com/Ultimaker/Cura/releases/download/{{ version }}/Ultimaker_Cura-{{ version }}.AppImage
    - skip_verify: True
    - user: root
    - group: root
    - mode: 755
    - makedirs: true

/usr/share/applications/cura.desktop:
  file.managed:
    - source: salt://cura/cura.desktop
