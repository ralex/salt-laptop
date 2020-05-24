git:
  pkg.installed

deb https://packagecloud.io/github/git-lfs/debian/ bullseye main:
  pkgrepo.managed:
    - humanname: Github git lfs
    - file: /etc/apt/sources.list.d/github_git-lfs.list
    - key_url: https://packagecloud.io/github/git-lfs/gpgkey

git-lfs:
  pkg.installed

{% for user in pillar.get('users', {}) %}
terminator-config_{{ user }}:
  file.managed:
    - name:  /home/{{ user }}/.config/terminator/config
    - source: salt://terminator/config.j2
{% endfor %}

{% for user in pillar.get('users', {}) %}
git lfs install for {{ user }}:
  cmd.run:
    - name: git lfs install
    - user: {{ user }}
    - check_cmd:
      - /bin/true
    - onchanges:
      - pkgrepo: /etc/apt/sources.list.d/github_git-lfs.list
{% endfor %}
