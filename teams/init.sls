curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/teams-keyring.gpg:
  cmd.run:
    - unless: test -f /usr/share/keyrings/teams-keyring.gpg

deb [signed-by=/usr/share/keyrings/teams-keyring.gpg arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/teams.list

teams:
  pkg.installed

{% for key, user in pillar.get('users', {}).items() %}
/home/{{ key }}/.config/regolith3/i3/config.d/50_teams:
  file.managed:
    - contents: |
        assign [class="Microsoft Teams - Preview"] $ws9
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644
{% endfor %}
