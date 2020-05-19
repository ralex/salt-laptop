sublime-text-requirements:
  pkg.installed:
    - pkgs:
      - apt-transport-https

sublime-text-repo:
  pkgrepo.absent:
    - humanname: Sublime Text 3
    - name: deb https://download.sublimetext.com/ apt/stable/
    - file: /etc/apt/sources.list.d/sublime-text.list
    - key_url: https://download.sublimetext.com/sublimehq-pub.gpg

sublime-text:
  pkg.removed

{% for user in pillar.get('users', {}) %}
/home/{{ user }}/.config/sublime-text-3/Packages/User/Preferences.sublime-settings:
  file.absent:
    - source: salt://sublime-text/user.json
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644
{% endfor %}

{% for user in pillar.get('users', {}) %}
/home/{{ user }}/.config/sublime-text-3/Packages/User/Package Control.sublime-settings:
  file.absent:
    - source: salt://sublime-text/packages.json
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644
{% endfor %}
