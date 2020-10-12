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
    - vim
    - vscode
    - keybase
    - terraform

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
    - trivy

  'G@os:Debian':
    - match: grain
    - debian
