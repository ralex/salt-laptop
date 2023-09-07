deb [arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] https://regolith-desktop.org/release-debian-bullseye-amd64 bullseye main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/regolith.list
    - key_url: https://regolith-desktop.org/regolith.key
    - aptkey: False

regolith.packages:
  pkg.installed:
    - pkgs:
      - regolith-desktop
      - regolith-compositor-picom-glx
      - regolith-look-ayu-dark
      - i3xrocks-battery
      - i3xrocks-bluetooth
      - i3xrocks-key-indicator
      - i3xrocks-media-player
      - i3xrocks-microphone
      - i3xrocks-net-traffic
      - i3xrocks-rofication
      - i3xrocks-tailscale
      - i3xrocks-volume
      - i3xrocks-wifi

regolith.uninstall:
  pkg.removed:
    - pkgs:
      - regolith-i3-control-center-gnome
      - regolith-i3-default-style
      - regolith-i3-ilia
      - regolith-i3-navigation
      - regolith-i3-next-workspace
      - regolith-i3-session
      - regolith-i3-swap-focus
      - regolith-i3-workspace-config

{% for key, user in pillar.get('users', {}).items() %}
/var/lib/AccountsService/users/{{ key }}:
  file.managed:
    - contents: |
        [User]
        Session=regolith
        Icon=/home/{{ key }}/.face
        SystemAccount=false
    - user: root
    - group: root
    - mode: 644

# Additional files not used for now, conflicting with
# regolith-i3-* packages installed with regolith-desktop
#
# "20_ilia"
# "30_navigation"
# "40_default-style"
# "40_i3-swap-focus"
# "40_next-workspace"
# "40_workspace-config"
# "55_session_keybindings"
# "60_gnome_config_keybindings"

{% set files = [
  "50_windows_assignment",
  "50_workspaces_layout"
]
%}
{% for file in files %}
/home/{{ key }}/.config/regolith2/i3/config.d/{{ file }}:
  file.managed:
    - source: salt://regolith-desktop/i3/{{ file }}
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - makedirs: True
    - mode: 644
{% endfor %}

/home/{{ key }}/.config/regolith2/Xresources:
  file.managed:
    - source: salt://regolith-desktop/Xresources
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - makedirs: True
    - mode: 644

regolith-look refresh for {{ key }}:
  cmd.run:
    - name: regolith-look refresh
    - env:
      - XDG_SESSION_TYPE: x11
    - user: {{ key }}
    - onchanges:
      - pkg: regolith.packages
      - pkg: regolith.uninstall
      - file: /home/{{ key }}/.config/regolith2/Xresources
      {% for file in files %}
      - file: /home/{{ key }}/.config/regolith2/i3/config.d/{{ file }}
      {% endfor %}
{% endfor %}
