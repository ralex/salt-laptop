
/etc/apt/trusted.gpg.d/keybase.asc:
  file.managed:
    - source: https://keybase.io/docs/server_security/code_signing_key.asc
    - source_hash: https://raw.githubusercontent.com/keybase/client/master/packaging/linux/code_signing_fingerprint
    - user: root
    - group: root
    - mode: 0644

keybase:
  pkg.installed:
    - sources:
      - keybase: https://prerelease.keybase.io/keybase_amd64.deb
