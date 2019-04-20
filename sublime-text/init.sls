sublime-text-requirements:
  pkg.installed:
    - pkgs:
      - apt-transport-https

sublime-text-repo:
  pkgrepo.managed:
    - humanname: Sublime Text 3
    - name: deb https://download.sublimetext.com/ apt/stable/
    - file: /etc/apt/sources.list.d/sublime-text.list
    - key_url: https://download.sublimetext.com/sublimehq-pub.gpg

sublime-text:
  pkg.installed

