deb [signed-by=/etc/apt/trusted.gpg.d/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/mozilla.list
    - key_url: https://packages.mozilla.org/apt/repo-signing-key.gpg
    - aptkey: False

gpg -n -q --import --import-options import-show /etc/apt/trusted.gpg.d/packages.mozilla.org.asc | grep -E [0-9a-fA-F]{40}:
  cmd.run:
    - success_stdout: '35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3'

firefox-nightly-packages:
  pkg.installed:
    - pkgs:
      - firefox-nightly
      - firefox-nightly-l10n-fr
