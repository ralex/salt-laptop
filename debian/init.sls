testing-wise:
  pkg.installed:
    - pkgs:
      - apt-listchanges
      - apt-listbugs

/etc/apt/sources.list:
  file.managed:
    - contents:
      - deb [signed-by=/usr/share/keyrings/debian-archive-keyring.gpg] http://deb.debian.org/debian testing main contrib non-free non-free-firmware
      - deb [signed-by=/usr/share/keyrings/debian-archive-keyring.gpg] http://deb.debian.org/debian testing-updates main contrib non-free non-free-firmware
      - deb [signed-by=/usr/share/keyrings/debian-archive-keyring.gpg] http://security.debian.org/debian-security testing-security main contrib non-free non-free-firmware
      - deb [signed-by=/usr/share/keyrings/debian-archive-keyring.gpg] http://deb.debian.org/debian bullseye main contrib non-free
      - deb [signed-by=/usr/share/keyrings/debian-archive-keyring.gpg] http://deb.debian.org/debian bullseye-updates main contrib non-free
      - deb [signed-by=/usr/share/keyrings/debian-archive-keyring.gpg] http://security.debian.org/debian-security bullseye-security/updates main contrib non-free

/etc/apt/preferences.d/pinning:
  file.managed:
    - contents: |
        Package: *
        Pin: release a=testing
        Pin-Priority: 500

        Package: *
        Pin: release a=stable
        Pin-Priority: 500

        Package: *
        Pin: release n=sid
        Pin-Priority: 100
        
