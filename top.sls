base:
  '*':
    - salt
    - i3
    - sddm
    - ssh.client
    - sublime-text
    - terminator
    - taskwarrior
    - signal
    - spotify
    - docker
    - vagrant-libvirt
    - minikube
    - kubernetes-client
    - vscode
    - cura

  'os:Debian':
    - match: grain
    - debian
