deb https://deb.nodesource.com/node_14.x buster main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/nodesource.list
    - key_url: https://deb.nodesource.com/gpgkey/nodesource.gpg.key

deb https://dl.yarnpkg.com/debian/ stable main:
  pkgrepo.absent:
    - file: /etc/apt/sources.list.d/yarn.list
    - key_url: https://dl.yarnpkg.com/debian/pubkey.gpg

nodejs-packages:
  pkg.installed:
    - pkgs:
      - nodejs
      - yarn
