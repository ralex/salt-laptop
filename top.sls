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

  'G@roles:home':
    - docker
    - kubernetes-client
    - cura

  'G@roles:work':
    - common
    - cntlm
    - docker-cds

  'os:Debian':
    - match: grain
    - debian
