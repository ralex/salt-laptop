{% from "kubernetes-client/map.jinja" import kubernetes_client with context %}

curl https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | gpg --dearmor > /etc/apt/keyrings/kubernetes-apt-keyring.gpg:
  cmd.run:
    - unless: test -f /etc/apt/keyrings/kubernetes-apt-keyring.gpg

deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/kubernetes.list

kubernetes-client-packages:
  pkg.installed:
    - pkgs: {{ kubernetes_client.packages }}

curl https://baltocdn.com/helm/signing.asc | gpg --dearmor > /usr/share/keyrings/helm-keyring.gpg:
  cmd.run:
    - unless: test -f /usr/share/keyrings/helm-keyring.gpg

deb [signed-by=/usr/share/keyrings/helm-keyring.gpg arch=amd64] https://baltocdn.com/helm/stable/debian/ all main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/helm-stable-debian.list

helm:
  pkg.installed

https://github.com/ralex/kube-ps1:
  git.latest:
    - rev: master
    - target: /usr/local/share/kube-ps1
    - user: root

{% for key, user in pillar.get('users', {}).items() %}
/home/{{ key }}/.bashrc.d/kubernetes-client.bashrc:
  file.managed:
    - source: salt://kubernetes-client/bashrc
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644
{% endfor %}
