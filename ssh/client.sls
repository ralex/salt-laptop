openssh-client:
  pkg.installed

{% for user in pillar.get('users', {}) %}
/home/{{ user }}/.ssh/config:
  file.managed:
    - source: salt://ssh/client_config.j2
    - template: jinja
{% endfor %}
