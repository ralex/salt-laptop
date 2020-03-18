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
