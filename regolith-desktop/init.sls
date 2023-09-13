deb [arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] https://regolith-desktop.org/release-3_0-debian-bookworm-amd64 bookworm main:
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
      - regolith-wm-user-programs
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

xdg-desktop-portal-gnome:
  pkg.removed

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

{% set i3_files = [
  "50_windows_assignment",
  "50_workspaces_layout"
]
%}
{% for file in i3_files %}
/home/{{ key }}/.config/regolith3/i3/config.d/{{ file }}:
  file.managed:
    - source: salt://regolith-desktop/i3/{{ file }}
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - makedirs: True
    - mode: 644
{% endfor %}

{% set i3xrocks_files = [
  "01_setup",
  "10_media-player",
  "20_key-indicator",
  "30_bluetooth",
  "30_wifi",
  "40_tailscale",
  "80_battery",
  "80_volume",
  "90_microphone",
  "90_rofication",
  "90_time"
]
%}
{% for file in i3xrocks_files %}
/home/{{ key }}/.config/regolith3/i3xrocks/conf.d/{{ file }}:
  file.managed:
    - source: salt://regolith-desktop/i3xrocks/{{ file }}
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - makedirs: True
    - mode: 644
{% endfor %}

/home/{{ key }}/.config/regolith3/Xresources:
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
      - file: /home/{{ key }}/.config/regolith3/Xresources
      {% for file in i3_files %}
      - file: /home/{{ key }}/.config/regolith3/i3/config.d/{{ file }}
      {% endfor %}
      {% for file in i3xrocks_files %}
      - file: /home/{{ key }}/.config/regolith3/i3xrocks/conf.d/{{ file }}
      {% endfor %}
{% endfor %}
