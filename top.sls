base:
  '*':
    - salt
    - i3
    - sddm
    - ssh.client
    - sublime-text
    - terminator
    - taskwarrior
    - spotify
    - virtualbox

  'os:Debian':
    - match: grain
    - debian
