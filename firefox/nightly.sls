firefox-nightly-packages:
  pkg.installed:
    - pkgs:
      - firefox-nightly
      - firefox-nightly-l10n-fr

{% for key, user in pillar.get('users', {}).items() %}
/home/{{ key }}/.config/regolith3/i3/config.d/50_firefox-nightly:
  file.managed:
    - contents: |
        assign [class="firefox-nightly"] $ws2
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644
{% endfor %}
