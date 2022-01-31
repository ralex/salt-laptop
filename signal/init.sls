deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/signal.list
    - key_url: https://updates.signal.org/desktop/apt/keys.asc

signal-desktop:
  pkg.installed
