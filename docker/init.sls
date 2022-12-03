deb [signed-by=/etc/apt/keyrings/docker.gpg arch=amd64] https://download.docker.com/linux/debian bullseye stable:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/docker.list
    - key_url: https://download.docker.com/linux/debian/gpg
    - aptkey: False

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

{% for key, user in pillar.get('users', {}).items() %}
/home/{{ key }}/.bashrc.d/docker.bashrc:
  file.managed:
    - source: salt://docker/docker.bashrc.j2
    - template: jinja
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644
    - makedirs: true
{% endfor %}
