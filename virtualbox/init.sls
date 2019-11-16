deb https://people.debian.org/~lucas/virtualbox-buster/ ./:
  pkgrepo.managed:
    - humanname: Virtualbox
    - file: /etc/apt/sources.list.d/virtualbox.list
    - key_url: https://db.debian.org/fetchkey.cgi?fingerprint=FEDEC1CB337BCF509F43C2243914B532F4DFBE99

virtualbox:
  pkg.installed

virtualbox.service:
  service.running:
    - enable: True
