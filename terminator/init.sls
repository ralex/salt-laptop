terminator-packages:
  pkg.installed:
    - pkgs:
      - terminator
      - fonts-inconsolata

{% for user in pillar.get('users', {}) %}
 /home/{{ user }}/.config/terminator/config:
  file.managed:
    - source: salt://terminator/config.j2

/home/{{ user }}/.config/regolith3/i3/config.d/50_terminator:
  file.managed:
    - contents: |
        assign [class="Terminator"] $ws1
    - user: root
    - group: root
    - mode: 644
{% endfor %}
