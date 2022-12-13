{% for key, user in pillar.get('users', {}).items() %}
https://github.com/ralex/asdf.git:
  git.latest:
    - target: /home/{{ key }}/.asdf
    - user: {{ user.uid }}
    - group: {{ user.gid }}

/home/{{ key }}/.bashrc.d/asdf.bashrc:
  file.managed:
    - source: salt://asdf/bashrc
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644
{% endfor %}
