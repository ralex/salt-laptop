openssh-client:
  pkg.installed

/root/.ssh/config:
  file.managed:
    - source: salt://ssh/client_config.j2
    - template: jinja

{% for user in pillar.get('users', {}) %}
/home/{{ user }}/.ssh/config:
  file.managed:
    - source: salt://ssh/client_config.j2
    - template: jinja

/etc/systemd/system/ssh-agent@{{ user }}.service:
  file.managed:
    - source: salt://ssh/ssh-agent.service.j2
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644
    - template: jinja

ssh-agent@{{ user }}.service:
  service.running:
    - enable: True
    - watch:
      - file: /etc/systemd/system/ssh-agent@{{ user }}.service
{% endfor %}
