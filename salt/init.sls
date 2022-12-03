deb [signed-by=/etc/apt/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/salt/py3/debian/11/amd64/latest bullseye main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/saltstack.list
    - key_url: https://repo.saltproject.io/salt/py3/debian/11/amd64/latest/salt-archive-keyring.gpg
    - aptkey: False

code:
  pkg.installed
