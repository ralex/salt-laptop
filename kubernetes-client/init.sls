{% from "kubernetes-client/map.jinja" import kubernetes_client with context %}

deb https://apt.kubernetes.io/ kubernetes-xenial main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/kubernetes.list
    - key_url: https://packages.cloud.google.com/apt/doc/apt-key.gpg

kubernetes-client-packages:
  pkg.installed:
    - pkgs: {{ kubernetes_client.packages }}

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
