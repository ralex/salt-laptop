{% for key, user in pillar.get('users', {}).items() %}
/home/{{ key }}/.bashrc:
  file.managed:
    - source: salt://bash/bashrc
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644

/home/{{ key }}/.inputrc:
  file.managed:
    - source: salt://bash/inputrc
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644
{% endfor %}
