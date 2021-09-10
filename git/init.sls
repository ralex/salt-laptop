git:
  pkg.installed

git-lfs:
  pkg.installed

{% for user in pillar.get('users', {}) %}
git lfs install for {{ user }}:
  cmd.run:
    - name: git lfs install
    - user: {{ user }}
    - check_cmd:
      - /bin/true
    - onchanges:
      - pkg: git-lfs
{% endfor %}
