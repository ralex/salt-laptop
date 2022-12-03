deb [signed-by=/etc/apt/keyrings/microsoft.gpg arch=amd64] https://packages.microsoft.com/repos/vscode stable main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/vscode.list
    - key_url: https://packages.microsoft.com/keys/microsoft.asc
    - aptkey: False

code:
  pkg.installed
