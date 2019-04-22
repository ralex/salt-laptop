sublime-text-requirements:
  pkg.installed:
    - pkgs:
      - apt-transport-https

sublime-text-repo:
  pkgrepo.managed:
    - humanname: Sublime Text 3
    - name: deb https://download.sublimetext.com/ apt/stable/
    - file: /etc/apt/sources.list.d/sublime-text.list
    - key_url: https://download.sublimetext.com/sublimehq-pub.gpg

sublime-text:
  pkg.installed

{% for user in pillar.get('users', {}) %}
sublime-text-user_config_{{ user }}:
  file.managed:
    - name:  /home/{{ user }}/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
    - source: salt://sublime-text/user.json
{% endfor %}

{% for user in pillar.get('users', {}) %}
sublime-text-packages_config_{{ user }}:
  file.managed:
    - name:  /home/{{ user }}/.config/sublime-text-3/Packages/User/Package Control.sublime-settings
    - source: salt://sublime-text/packages.json
{% endfor %}
