testing-wise:
  pkg.installed:
    - pkgs:
      - apt-listchanges
      - apt-listbugs

/etc/apt/sources.list:
  file.managed:
    - contents:
      - deb http://deb.debian.org/debian testing main contrib non-free
      - deb http://deb.debian.org/debian testing-updates main contrib non-free
      - deb http://security.debian.org/debian-security/ testing-security main contrib non-free
