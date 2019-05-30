i3-related-packages:
  pkg.installed:
    - pkgs:
      - i3-wm
      - i3status
      - i3lock
      - fonts-font-awesome
      - arc-theme
      - rofi
      - dunst
      - scrot
      - imagemagick
      - python-pip

pypandoc:
  pip.installed:
    - require:
      - pkg: i3-related-packages

fontawesome:
  pip.installed:
    - require:
      - pkg: pypandoc

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
        gtk-theme-name = Arc-Darker
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644
{% endfor %}
