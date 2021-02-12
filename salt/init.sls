salt-minion:
  service.dead:
    - enable: False

/etc/salt/minion.d/file_client.conf:
  file.managed:
    - contents:
      - 'file_client: local'
    - user: root
    - group: root
    - mode: 644

/etc/salt/minion.d/fileserver.conf:
  file.managed:
    - source: salt://salt/fileserver.conf.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 644

salt-call --local state.apply -l error:
  cron.present:
    - user: root
    - minute: '*/30'
