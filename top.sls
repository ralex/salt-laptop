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
    - virtualbox
    - docker

  'os:Debian':
    - match: grain
    - debian
