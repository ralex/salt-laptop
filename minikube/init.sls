/usr/local/bin/minikube:
  file.managed:
    - source: https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    - source_hash: https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64.sha256
    - user: root
    - group: root
    - mode: 0755

{% for user in pillar.get('users', {}) %}
/home/{{ user }}/.minikube/config/config.json:
  file.managed:
    - source: salt://minikube/config.json
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644
{% endfor %}
