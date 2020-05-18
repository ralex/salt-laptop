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
      - deb http://security.debian.org/debian-security testing-security main contrib non-free
      - deb http://deb.debian.org/debian buster main contrib non-free
      - deb http://deb.debian.org/debian buster-updates main contrib non-free
      - deb http://security.debian.org/debian-security buster/updates main contrib non-free


/etc/apt/preferences.d/pinning:
  file.managed:
    - contents: |
        Package: *
        Pin: release a=testing
        Pin-Priority: 700

        Package: *
        Pin: release a=stable
        Pin-Priority: 650

        Package: *
        Pin: release n=sid
        Pin-Priority: 100
