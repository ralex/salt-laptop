git:
  pkg.installed

deb https://packagecloud.io/github/git-lfs/debian/ buster main:
  pkgrepo.managed:
    - humanname: Github git lfs
    - file: /etc/apt/sources.list.d/github_git-lfs.list
    - key_url: https://packagecloud.io/github/git-lfs/gpgkey

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
      - pkgrepo: deb https://packagecloud.io/github/git-lfs/debian/ buster main
      - pkg: git-lfs
{% endfor %}
