salt-minion:
  service.dead:
    - enable: False

salt-call --local state.apply -l error:
  cron.present:
    - user: root
    - minute: '*/30'
