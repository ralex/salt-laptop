twitch-related-packages:
  pkg.installed:
    - pkgs:
      - vlc
      - streamlink

{% set ttchat_version = salt['pillar.get']('ttchat:version', '0.1.6') %}
/usr/local/bin/ttchat:
  archive.extracted:
    - source: https://github.com/atye/ttchat/releases/download/v{{ ttchat_version }}/ttchat_0.1.6_linux_amd64.tar.gz
    - source_hash: https://github.com/atye/ttchat/releases/download/v{{ ttchat_version }}/ttchat_{{ ttchat_version }}_checksums.txt
    - source_hash_name: ttchat_{{ ttchat_version }}_linux_amd64.tar.gz
    - enforce_toplevel: False
    - user: root
    - group: root

{% for key, user in pillar.get('users', {}).items() %}
/home/{{ key }}/.bashrc.d/twitch.bashrc:
  file.managed:
    - source: salt://twitch/bashrc
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644
{% endfor %}
