{% for user in pillar.get('users', {}) %}
/home/{{ user }}/.bashrc:
  file.managed:
    - source: salt://bash/bashrc
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644

/home/{{ user }}/.inputrc:
  file.managed:
    - source: salt://bash/inputrc
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644
{% endfor %}
