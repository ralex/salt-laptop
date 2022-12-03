deb https://deb.nodesource.com/node_14.x bullseye main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/nodesource.list
    - key_url: https://deb.nodesource.com/gpgkey/nodesource.gpg.key
    - aptkey: False

deb https://dl.yarnpkg.com/debian stable main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/yarn.list
    - key_url: https://dl.yarnpkg.com/debian/pubkey.gpg
    - aptkey: False

nodejs-packages:
  pkg.installed:
    - pkgs:
      - nodejs
      - yarn
