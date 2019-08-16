base:
  '*':
    - salt
    - i3
    - sublime-text
    - terminator
    - taskwarrior

  'os:Debian':
    - match: grain
    - debian
