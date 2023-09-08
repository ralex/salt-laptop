terminator-packages:
  pkg.installed:
    - pkgs:
      - terminator
      - fonts-inconsolata

{% for key, user in pillar.get('users', {}).items() %}
/home/{{ key }}/.config/terminator/config:
  file.managed:
    - source: salt://terminator/config.j2

/home/{{ key }}/.config/regolith3/i3/config.d/50_terminator:
  file.managed:
    - contents: |
        assign [class="Terminator"] $ws1
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644
{% endfor %}
