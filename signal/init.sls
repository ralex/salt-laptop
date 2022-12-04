curl https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > /usr/share/keyrings/signal-archive-keyring.gpg:
  cmd.run:
    - unless: test -f /usr/share/keyrings/signal-archive-keyring.gpg

deb [signed-by=/usr/share/keyrings/signal-archive-keyring.gpg arch=amd64] https://updates.signal.org/desktop/apt xenial main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/signal.list

signal-desktop:
  pkg.installed
