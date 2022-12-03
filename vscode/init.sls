curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/microsoft-keyring.gpg:
  cmd.run

deb [signed-by=/usr/share/keyrings/microsoft-keyring.gpg arch=amd64] https://packages.microsoft.com/repos/vscode stable main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/vscode.list

code:
  pkg.installed
