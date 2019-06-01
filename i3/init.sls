i3-related-packages:
  pkg.installed:
    - pkgs:
      - bc
      - git
      - i3-wm
      - i3status
      - i3lock
      - feh
      - fonts-font-awesome
      - arc-theme
      - rofi
      - dunst
      - scrot
      - imagemagick
      - python3
      - python3-pip
      - pandoc

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

https://github.com/graysky2/pulseaudio-ctl:
  git.latest:
    - rev: v1.66
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
      - git: https://github.com/graysky2/pulseaudio-ctl
    - onchanges:
      - git: https://github.com/graysky2/pulseaudio-ctl

{% for user in pillar.get('users', {}) %}
/var/lib/AccountsService/users/{{ user }}:
  file.managed:
    - contents: |
        [User]
        Language=
        XSession=i3
        SystemAccount=false
    - user: root
    - group: root
    - mode: 644

/home/{{ user }}/.config/gtk-3.0/settings.ini:
  file.managed:
    - contents: |
        [Settings]
        gtk-application-prefer-dark-theme = 0
        gtk-theme-name = Arc
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644
{% endfor %}

{% for user in pillar.get('users', {}) %}
/home/{{ user}}/.config/i3/i3status.conf:
  file.managed:
    - source: salt://i3/i3status.conf.j2
    - template: jinja
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644
{% endfor %}

{% for user in pillar.get('users', {}) %}
i3-msg restart:
  cmd.run:
    - user: {{ user }}
    - ignore_retcode: True
    - onchanges:
      - file: /home/{{ user}}/.config/i3/i3status.conf
{% endfor %}
