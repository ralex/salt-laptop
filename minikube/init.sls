/usr/local/bin/minikube:
  file.managed:
    - source: https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    - source_hash: https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64.sha256
    - user: root
    - group: root
    - mode: 0755

{% for key, user in pillar.get('users', {}).items() %}
/home/{{ key }}/.minikube/config/config.json:
  file.managed:
    - source: salt://minikube/config.json
    - makedirs: True
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644
{% endfor %}
