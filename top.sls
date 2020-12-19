base:
  '*':
    - salt
    - bash
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
    - vim
    - vscode
    - keybase
    - terraform

  'roles:home':
    - match: grain
    - docker
    - kubernetes-client
    - cura

  'roles:work':
    - match: grain
    - common
    - cntlm
    - docker-cds
    - trivy

  'os:Debian':
    - match: grain
    - debian
