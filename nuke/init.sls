{% set nuke_version = salt['pillar.get']('nuke:version', '5.2.2') %}
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
/home/{{ key }}/.config/nuke/config.yml:
  file.managed:
    - source: salt://i3/nuke_config.yml
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - makedirs: True
    - mode: 644
{% endfor %}
