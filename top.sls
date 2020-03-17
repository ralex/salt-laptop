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

  'os:Debian':
    - match: grain
    - debian
