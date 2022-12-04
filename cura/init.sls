{% if salt['pillar.get']('github.com:token')|length %}
{% set curl_header = '-H "Authorization: token '~ salt['pillar.get']('github.com:token') ~'"' %}
{% else %}
{% set curl_header = '' %}
{% endif %}
{% if salt['pillar.get']('cura:version')|length %}
{% set cura_version = salt['pillar.get']('cura:version', salt['cmd.run']('curl '~ curl_header ~' -sL -t2 "https://api.github.com/repos/Ultimaker/Cura/releases/latest" | jq -r ".tag_name"', python_shell=True)) %}
{% endif %}
{% if cura_version is not defined or cura_version == 'null' %}
{% set cura_version = '5.2.1' %}
{% endif %}

/opt/cura/Ultimaker_Cura.AppImage:
  file.managed:
    - source: https://github.com/Ultimaker/Cura/releases/download/{{ cura_version }}/Ultimaker-Cura-{{ cura_version }}-linux.AppImage
    - skip_verify: True
    - user: root
    - group: root
    - mode: 755
    - makedirs: true

/usr/share/applications/cura.desktop:
  file.managed:
    - source: salt://cura/cura.desktop
