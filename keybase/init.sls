
/etc/apt/trusted.gpg.d/keybase.asc:
  file.managed:
    - contents:
      - source: https://keybase.io/docs/server_security/code_signing_key.asc
      - user: root
      - group: root
      - mode: 0644

keybase:
  pkg.installed:
    - sources:
      - keybase: https://prerelease.keybase.io/keybase_amd64.deb
