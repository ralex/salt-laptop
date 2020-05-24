{% set version = salt['pillar.get']('cura:version', '4.5.0') %}

/opt/cura/Ultimaker_Cura.AppImage:
  file.managed:
    - source: https://software.ultimaker.com/cura/Ultimaker_Cura-{{ version }}.AppImage
    - source_hash: sha256=de20f13db7d1e4dea382e1c8ee6f31532cec072576b4fa508ccf00030aeb09b3
    - user: root
    - group: root
    - mode: 755
    - makedirs: true

/usr/share/applications/cura.desktop:
  file.managed:
    - source: salt://cura/cura.desktop
