curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/vscode-keyring.gpg:
  cmd.run:
    - unless: test -f /usr/share/keyrings/vscode-keyring.gpg

deb [signed-by=/usr/share/keyrings/vscode-keyring.gpg arch=amd64] https://packages.microsoft.com/repos/vscode stable main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/vscode.list

code:
  pkg.installed

/etc/sysctl.d/inotify.conf:
  file.managed:
    - contents: |
          fs.inotify.max_user_watches=524288

    - user: root
    - group: root
    - mode: 644

{% for key, user in pillar.get('users', {}).items() %}
/home/{{ key }}/.config/regolith3/i3/config.d/50_vscode:
  file.managed:
    - contents: |
        assign [class="Code"] $ws4
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644
{% endfor %}
