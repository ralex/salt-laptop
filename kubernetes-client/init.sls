{% from "kubernetes-client/map.jinja" import kubernetes_client with context %}

deb [signed-by=/etc/apt/trusted.gpg.d/kubernetes.gpg] https://apt.kubernetes.io kubernetes-xenial main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/kubernetes.list
    - key_url: https://packages.cloud.google.com/apt/doc/apt-key.gpg
    - aptkey: False

kubernetes-client-packages:
  pkg.installed:
    - pkgs: {{ kubernetes_client.packages }}

curl https://baltocdn.com/helm/signing.asc | gpg --dearmor > /usr/share/keyrings/helm-keyring.gpg:
  cmd.run
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
