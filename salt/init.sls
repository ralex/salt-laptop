salt-minion:
  service.dead:
    - enable: False

salt-call --local state.apply:
  cron.present:
    - user: root
    - minute: '*/30'
