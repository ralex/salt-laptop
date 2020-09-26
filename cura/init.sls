{% set version = salt['pillar.get']('cura:version', '4.5.0') %}

/opt/cura/Ultimaker_Cura.AppImage:
  file.managed:
    - source: https://github.com/Ultimaker/Cura/releases/download/{{ version }}/Ultimaker_Cura-{{ version }}.AppImage
    - skip_verify: True
    - user: root
    - group: root
    - mode: 755
    - makedirs: true

/usr/share/applications/cura.desktop:
  file.managed:
    - source: salt://cura/cura.desktop
