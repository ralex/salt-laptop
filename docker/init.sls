deb [arch=amd64] https://download.docker.com/linux/debian buster stable:
  pkgrepo.managed:
    - humanname: Docker
    - file: /etc/apt/sources.list.d/docker.list
    - key_url: https://download.docker.com/linux/debian/gpg

docker.packages:
  pkg.installed:
    - pkgs:
      - docker-ce
      - docker-ce-cli
      - containerd.io

docker:
  group.present:
    - members:
    {% for user in pillar.get('users', {}) %}
      - {{ user }}
    {% endfor %}

{% for user in pillar.get('users', {}) %}
/home/{{ user }}/.bashrc.d/docker.bashrc:
  file.managed:
    - source: salt://docker/docker.bashrc.j2
    - template: jinja
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644
    - makedirs: true
{% endfor %}
