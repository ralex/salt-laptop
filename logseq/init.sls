{% if salt['pillar.get']('github.com:token')|length %}
{% set curl_header = '-H "Authorization: token '~ salt['pillar.get']('github.com:token') ~'"' %}
{% else %}
{% set curl_header = '' %}
{% endif %}
{% if salt['pillar.get']('logseq:version')|length %}
{% set logseq_version = salt['pillar.get']('logseq:version', salt['cmd.run']('curl '~ curl_header ~' -sL -t2 "https://api.github.com/repos/logseq/logseq/releases/latest" | jq -r ".tag_name"', python_shell=True)) %}
{% endif %}
{% if logseq_version is not defined or logseq_version == 'null' %}
{% set logseq_version = '0.9.18' %}
{% endif %}

/opt/logseq/Logseq-linux.AppImage:
  file.managed:
    - source: https://github.com/logseq/logseq/releases/download/{{ logseq_version }}/Logseq-linux-x64-{{ logseq_version }}.AppImage
    - source_hash: https://github.com/logseq/logseq/releases/download/{{ logseq_version }}/SHA256SUMS.txt
    - user: root
    - group: root
    - mode: 755
    - makedirs: true

/opt/logseq/icon.png:
  file.managed:
    - source: https://raw.githubusercontent.com/logseq/logseq/master/resources/img/logo.png
    - skip_verify: True
    - user: root
    - group: root
    - mode: 644
    - makedirs: true

/usr/share/applications/logseq.desktop:
  file.managed:
    - source: salt://logseq/logseq.desktop

{% for key, user in pillar.get('users', {}).items() %}
/home/{{ key }}/.config/regolith3/i3/config.d/50_logseq:
  file.managed:
    - contents: |
        assign [class="Logseq"] $ws7
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644
{% endfor %}
