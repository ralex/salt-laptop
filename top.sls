base:
  '*':
    - salt

  'roles:laptop':
    - match: grain
    - bash
    - git
    - i3
    - keybase
    - kubernetes-client
    - minikube
    - sddm
    - signal
    - spotify
    - ssh.client
    - taskwarrior
    - terminator
    - terraform
    - vagrant-libvirt
    - vim
    - vscode

  'roles:home':
    - match: grain
    - cura
    - docker
    - tailscale

  'roles:work':
    - match: grain
    - cntlm
    - common
    - docker-cds
    - trivy

  'os:Debian and roles:laptop':
    - match: grain
    - debian
