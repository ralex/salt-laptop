base:
  '*':
    - salt
    - i3
    - ssh.client
    - sublime-text
    - terminator
    - taskwarrior

  'os:Debian':
    - match: grain
    - debian
