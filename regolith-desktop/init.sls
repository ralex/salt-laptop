deb [arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] https://regolith-desktop.org/release-debian-bullseye-amd64 bullseye main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/regolithœ.list
    - key_url: https://regolith-desktop.org/regolith.key
    - aptkey: False

regolith.packages:
  pkg.installed:
    - pkgs:
      - regolith-desktop
      - regolith-compositor-picom-glx
