keybase-requirements:
  pkg.installed:
    - pkgs:
      - libappindicator1
      - libayatana-appindicator1
      - libgconf-2-4
      - lsof

keybase:
  pkg.installed:
    - sources:
      - keybase: https://prerelease.keybase.io/keybase_amd64.deb
