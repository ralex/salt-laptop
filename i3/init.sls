i3-related-packages:
  pkg.installed:
    - pkgs:
      - arc-theme
      - bc
      - compton
      - dunst
      - feh
      - fonts-font-awesome
      - git
      - i3-wm
      - i3status
      - imagemagick
      - libnotify-bin
      - mplayer
      - numlockx
      - pandoc
      - pass
      - playerctl
      - python3
      - python3-pip
      - redshift-gtk
      - rofi
      - scrot
      - wmctrl
      - xss-lock
      - xsecurelock

pypandoc:
  pip.installed:
    - bin_env: '/usr/bin/pip3'
    - require:
      - pkg: i3-related-packages

i3-pip-packages:
  pip.installed:
    - pkgs:
      - fontawesome
      - taskw
    - bin_env: '/usr/bin/pip3'
    - require:
      - pip: pypandoc

https://github.com/ralex/pulseaudio-ctl:
  git.latest:
    - rev: master
    - target: /usr/local/src/pulseaudio-ctl
    - user: root
    - require:
      - pkg: i3-related-packages

pulseaudio-ctl:
  cmd.run:
    - cwd: /usr/local/src/pulseaudio-ctl
    - user: root
    - name: make install
    - require:
      - git: https://github.com/ralex/pulseaudio-ctl
    - onchanges:
      - git: https://github.com/ralex/pulseaudio-ctl

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
    - user: {{ user }}
    - check_cmd:
      - /bin/true
    - onchanges:
      - file: /home/{{ user}}/.config/i3/i3status.conf
      - file: /home/{{ user}}/.config/compton.conf
{% endfor %}
