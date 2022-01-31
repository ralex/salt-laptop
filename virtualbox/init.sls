fasttrack-archive-keyring:
  pkg.installed

deb https://fasttrack.debian.net/debian-fasttrack/ bullseye-fasttrack main contrib ./:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/virtualbox.list

virtualbox.packages:
  pkg.installed:
    - pkgs:
      - virtualbox
      - virtualbox-dkms

virtualbox.service:
  service.running:
    - enable: True
