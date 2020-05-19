base:
  '*':
    - salt
    - i3
    - sddm
    - ssh.client
    - terminator
    - taskwarrior
    - signal
    - spotify
    - vagrant-libvirt
    - minikube
    - vscode

  'roles:home':
    - docker
    - kubernetes-client
    - cura

  'os:Debian':
    - match: grain
    - debian
