sony-headphone-client-requirements:
  pkg.installed:
    - pkgs:
      - libglew2.1
      - libglfw3
      - libopengl0

{% set sony_headphone_client_version = salt['pillar.get']('sony_headphone_client:version', '1.2') %}
/usr/local/bin/sony-headphone-client:
  archive.extracted:
    - source: https://github.com/Plutoberth/SonyHeadphonesClient/releases/download/v{{ sony_headphone_client_version }}/SonyHeadphonesClient-linux-x64.zip
    - skip_verify: True
    - enforce_toplevel: False
    - user: root
    - group: root
    - mode: 0755

/usr/share/applications/sony-headphone-client.desktop:
  file.managed:
    - source: salt://sony-headphone-client/sony-headphone-client.desktop
