direnv:
  pkg.installed

{% for key, user in pillar.get('users', {}).items() %}
/home/{{ key }}/.bashrc.d/direnv.bashrc:
  file.managed:
    - contents: |
        eval "$(direnv hook bash)"
        
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644
{% endfor %}
