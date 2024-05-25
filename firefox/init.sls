mozilla-repo:
  pkgrepo.managed:
    - name: deb [signed-by=/etc/apt/trusted.gpg.d/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main
    - file: /etc/apt/sources.list.d/mozilla.list
    - key_url: https://packages.mozilla.org/apt/repo-signing-key.gpg
    - aptkey: False

gpg -n -q --import --import-options import-show /etc/apt/trusted.gpg.d/packages.mozilla.org.asc | grep -E [0-9a-fA-F]{40}:
  cmd.run:
    - success_stdout: '35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3'
    - onchanges:
      - pkgrepo: mozilla-repo

firefox-packages:
  pkg.installed:
    - pkgs:
      - firefox
      - firefox-l10n-fr

{% for key, user in pillar.get('users', {}).items() %}
/home/{{ key }}/.config/regolith3/i3/config.d/50_firefox:
  file.managed:
    - contents: |
        assign [class="firefox"] $ws2
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644
{% endfor %}
