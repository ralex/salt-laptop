{% for user in pillar.get('users', {}) %}
terminator-config_{{ user }}:
  file.managed:
    - name:  /home/{{ user }}/.config/terminator/config
    - source: salt://terminator/config.j2
{% endfor %}

terminator-packages:
  pkg.installed:
    - pkgs:
      - terminator
      - fonts-inconsolata
