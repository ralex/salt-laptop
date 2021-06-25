openssh-client:
  pkg.installed

/root/.ssh/config:
  file.managed:
    - source: salt://ssh/client_config.j2
    - template: jinja

{% for key, user in pillar.get('users', {}).items() %}
/home/{{ key }}/.ssh/config:
  file.managed:
    - source: salt://ssh/client_config.j2
    - template: jinja

/etc/systemd/system/ssh-agent@{{ key }}.service:
  file.managed:
    - source: salt://ssh/ssh-agent.service.j2
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644
    - template: jinja
    - defaults:
        user: {{ key }}

ssh-agent@{{ key }}.service:
  service.running:
    - enable: True
    - watch:
      - file: /etc/systemd/system/ssh-agent@{{ key }}.service
{% endfor %}
