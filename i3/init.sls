i3-related-packages:
  pkg.installed:
    - pkgs:
      - arandr
      - arc-theme
      - autorandr
      - bc
      - compton
      - dnsutils
      - dunst
      - evolution
      - evolution-ews
      - feh
      - fonts-font-awesome
      - git
      - gnome-control-center
      - gnome-screenshot
      - i3-wm
      - i3status
      - imagemagick
      - jq
      - libdbus-1-dev
      - libglib2.0-dev
      - libnotify-bin
      - locate
      - mplayer
      - nextcloud-desktop
      - numlockx
      - pandoc
      - pass
      - playerctl
      - polybar
      - python3
      - python3-pip
      - redshift-gtk
      - remmina
      - rofi
      - scrot
      - wmctrl
      - xsecurelock
      - xss-lock

/usr/share/applications/gnome-control-center.desktop:
  file.comment:
    - regex: ^OnlyShowIn

{% for user in pillar.get('users', {}) %}
/home/{{ user }}/.config/i3/venv:
  virtualenv.managed:
    - user: {{ user }}

i3-pip-packages:
  pip.installed:
    - pkgs:
      - dbus-python
      - fontawesome
      - pypandoc
      - taskw
    - bin_env: '/home/{{ user }}/.config/i3/venv'
    - user: {{ user }}
{% endfor %}

https://github.com/ralex/sway-tools:
  git.latest:
    - rev: main
    - force_fetch: True
    - force_reset: True
    - target: /usr/local/src/sway-tools
    - user: root
    - require:
      - pkg: i3-related-packages

{% for key, user in pillar.get('users', {}).items() %}
pw-volume-build:
  cmd.run:
    - cwd: /usr/local/src/sway-tools/pw-volume
    - runas: {{ key }}
    - name: cargo build -r --target-dir /tmp/
    - require:
      - git: https://github.com/ralex/sway-tools
    - onchanges:
      - git: https://github.com/ralex/sway-tools

/home/{{ key }}/.local/bin/pw-volume:
  file.managed:
    - source: /tmp/release/pw-volume
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 755
    - onchanges:
      - cmd: pw-volume-build
{% endfor %}

{% set nuke_version = salt['pillar.get']('nuke:version', '5.1.2') %}
/usr/src/nuke:
  archive.extracted:
    - source: https://github.com/gleich/nuke/releases/download/v{{ nuke_version }}/nuke_{{ nuke_version }}_linux_amd64.tar.gz
    - source_hash: https://github.com/gleich/nuke/releases/download/v{{ nuke_version }}/nuke_{{ nuke_version }}_checksums.txt
    - source_hash_name: nuke_{{ nuke_version }}_linux_amd64.tar.gz
    - enforce_toplevel: False
    - makedirs: True
    - user: root
    - group: root

/usr/local/bin/nuke:
  file.managed:
    - source: /usr/src/nuke/nuke
    - user: root
    - group: root
    - mode: '0755'
    - require:
      - archive: /usr/src/nuke

{% for key, user in pillar.get('users', {}).items() %}
/home/{{ key }}/.config/pulseaudio-ctl/config:
  file.managed:
    - source: salt://i3/pulseaudio-ctl.config
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644

/var/lib/AccountsService/users/{{ key }}:
  file.managed:
    - contents: |
        [User]
        Language=
        XSession=i3
        SystemAccount=false
    - user: root
    - group: root
    - mode: 644

/home/{{ key }}/.config/gtk-3.0/settings.ini:
  file.managed:
    - contents: |
        [Settings]
        gtk-application-prefer-dark-theme = 0
        gtk-theme-name = Arc
        gtk-font-name = DejaVu Sans 8
        
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644

/home/{{ key }}/.config/dunst/dunstrc:
  file.managed:
    - source: salt://i3/dunstrc
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - makedirs: True
    - mode: 644

/home/{{ key }}/.config/rofi/config.rasi:
  file.managed:
    - source: salt://i3/rofi/config.rasi
    - template: jinja
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - makedirs: True
    - mode: 644

/home/{{ key }}/.config/rofi/theme.rasi:
  file.managed:
    - source: salt://i3/rofi/theme.rasi
    - template: jinja
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - makedirs: True
    - mode: 644

/home/{{ key }}/.config/i3/config:
  file.managed:
    - source: salt://i3/config.j2
    - template: jinja
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644
    - context:
        i3_user: {{ key }}

/home/{{ key }}/.config/i3/i3status.conf:
  file.managed:
    - source: salt://i3/i3status.conf.j2
    - template: jinja
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644

/home/{{ key }}/.config/compton.conf:
  file.managed:
    - source: salt://i3/compton.conf.j2
    - template: jinja
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644

/home/{{ key  }}/.config/redshift.conf:
  file.managed:
    - source: salt://i3/redshift.conf.j2
    - template: jinja
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644

/home/{{ key }}/.config/nuke/config.yml:
  file.managed:
    - source: salt://i3/nuke_config.yml
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - makedirs: True
    - mode: 644
{% endfor %}

{% for user in pillar.get('users', {}) %}
i3-msg restart for {{ user }}:
  cmd.run:
    - name: i3-msg restart
    - env:
      - XDG_SESSION_TYPE: x11
    - user: {{ user }}
    - check_cmd:
      - /bin/true
    - onchanges:
      - file: /home/{{ user }}/.config/i3/i3status.conf
      - file: /home/{{ user }}/.config/compton.conf
{% endfor %}
