sddm:
  pkg.installed

qml-module-qtgraphicaleffects:
  pkg.installed

https://github.com/ralex/Elegant-sddm:
  git.latest:
    - rev: master
    - target: /usr/share/sddm/themes
    - force_clone: True
    - force_reset: True
    - user: root
    - require:
      - pkg: sddm
      - pkg: qml-module-qtgraphicaleffects

/etc/sddm.conf:
  file.managed:
    - source: salt://sddm/sddm.conf.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 644

/etc/systemd/system/display-manager.service:
  file.symlink:
    - target: /lib/systemd/system/sddm.service
