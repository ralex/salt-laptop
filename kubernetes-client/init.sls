deb https://apt.kubernetes.io/ kubernetes-xenial main:
  pkgrepo.managed:
    - humanname: kubectl
    - file: /etc/apt/sources.list.d/kubernetes.list
    - key_url: https://packages.cloud.google.com/apt/doc/apt-key.gpg

kubernetes-client-packages:
  pkg.installed:
    - pkgs:
      - kubectl
      - kubectx

https://github.com/ralex/kube-ps1:
  git.latest:
    - rev: master
    - target: /usr/local/share/kube-ps1
    - user: root

{% for user in pillar.get('users', {}) %}
/home/{{ user }}/.bashrc.d/kubernetes-client.bashrc:
  file.managed:
    - source: salt://kubernetes-client/bashrc
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644
{% endfor %}
