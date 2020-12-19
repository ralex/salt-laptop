{% for user in pillar.get('users', {}) %}
/home/{{ user }}/.bashrc:
  file.managed:
    - source: salt://bash/bashrc
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644

/home/{{ user }}/.inputrc:
  file.managed:
    - source: salt://bash/inputrc
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644
{% endfor %}
