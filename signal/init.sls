deb [signed-by=/etc/apt/keyrings/signal.gpg arch=amd64] https://updates.signal.org/desktop/apt xenial main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/signal.list
    - key_url: https://updates.signal.org/desktop/apt/keys.asc
    - aptkey: False

signal-desktop:
  pkg.installed
