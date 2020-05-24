base:
  '*':
    - salt
    - git
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
    - keybase

  'G@roles:home':
    - match: grain
    - docker
    - kubernetes-client
    - cura

  'G@roles:work':
    - match: grain
    - common
    - cntlm
    - docker-cds

  'G@os:Debian':
    - match: grain
    - debian
