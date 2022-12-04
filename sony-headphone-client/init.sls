{% if salt['pillar.get']('github.com:token')|length %}
{% set curl_header = '-H "Authorization: token '~ salt['pillar.get']('github.com:token') ~'"' %}
{% else %}
{% set curl_header = '' %}
{% endif %}
{% if salt['pillar.get']('sony_headphone_client:version')|length %}
{% set sony_headphone_client_version = salt['pillar.get']('sony_headphone_client:version', salt['cmd.run']('curl '~ curl_header ~' -sL -t2 "https://api.github.com/repos/Plutoberth/SonyHeadphonesClient/releases/latest" | jq -r ".tag_name"', python_shell=True)) %}
{% endif %}
{% if sony_headphone_client_version is not defined or sony_headphone_client_version == 'null' %}
{% set sony_headphone_client_version = 'v1.2' %}
{% endif %}

sony-headphone-client-requirements:
  pkg.installed:
    - pkgs:
      - libglew2.1
      - libglfw3
      - libopengl0

/usr/local/bin/sony-headphone-client:
  archive.extracted:
    - source: https://github.com/Plutoberth/SonyHeadphonesClient/releases/download/{{ sony_headphone_client_version }}/SonyHeadphonesClient-linux-x64.zip
    - skip_verify: True
    - enforce_toplevel: False
    - user: root
    - group: root

/usr/local/bin/sony-headphone-client/SonyHeadphonesClient:
  file.managed:
    - mode: 0755

/usr/share/applications/sony-headphone-client.desktop:
  file.managed:
    - source: salt://sony-headphone-client/sony-headphone-client.desktop
