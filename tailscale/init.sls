deb [signed-by=/etc/apt/keyrings/tailscale.gpg] https://pkgs.tailscale.com/stable/debian bullseye main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/tailscale.list
    - key_url: https://pkgs.tailscale.com/stable/debian/bullseye.gpg
    - aptkey: False

tailscale:
  pkg.installed
