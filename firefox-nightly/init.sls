deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/mozilla.list
    - key_url: https://packages.mozilla.org/apt/repo-signing-key.gpg
    - aptkey: False

firefox-nightly-packages:
  pkg.installed:
    - pkgs:
      - firefox-nightly
      - firefox-nightly-l10n-fr
