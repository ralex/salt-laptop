i3-additional-packages:
  pkg.installed:
    - pkgs:
      - arc-theme

{% for user in pillar.get('users', {}) %}
/home/{{ user }}/.config/gtk-3.0/settings.ini:
  file.managed:
    - source: salt://i3/gtk3-settings.ini
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644
{% endfor %}
