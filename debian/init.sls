testing-wise:
  pkg.installed:
    - pkgs:
      - apt-listchanges
      - apt-listbugs

testing-sources-list:
  file.managed:
  /etc/apt/sources.list
    - contents: |-
      deb http://deb.debian.org/debian testing main
      deb http://deb.debian.org/debian testing-updates main
      deb http://security.debian.org/debian-security/ testing/updates main
