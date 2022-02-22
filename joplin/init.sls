{% if salt['pillar.get']('github.com:token') is defined %}
{% set curl_header = '-H "Authorization: token '~ salt['pillar.get']('github.com:token') ~'"' %}
{% else %}
{% set curl_header = '' %}
{% endif %}
{% set version = salt['pillar.get']('joplin:version', salt['cmd.run']('curl '~ curl_header ~' -sL "https://api.github.com/repos/laurent22/joplin/releases/latest" | jq -r ".tag_name"', python_shell=True)) %}

/opt/joplin/Joplin.AppImage:
  file.managed:
    - source: https://github.com/laurent22/joplin/releases/download/{{ version }}/Joplin-{{ version }}.AppImage
    - source_hash: https://github.com/laurent22/joplin/releases/download/{{ version }}/Joplin-{{ version }}.AppImage.sha512
    - user: root
    - group: root
    - mode: 755
    - makedirs: true

{% for key, user in pillar.get('users', {}).items() %}
/home/{{ key }}/.local/share/icons/hicolor/512x512/apps/joplin.png:
  file.managed:
    - source: https://joplinapp.org/images/Icon512.png
    - skip_verify: True
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644
{% endfor %}

/usr/share/applications/joplin.desktop:
  file.managed:
    - source: salt://joplin/joplin.desktop
