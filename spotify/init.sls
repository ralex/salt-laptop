curl https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | gpg --dearmor > /etc/apt/trusted.gpg.d/spotify.gpg:
  cmd.run:
    - unless: test -f /etc/apt/trusted.gpg.d/spotify.gpg

deb [signed-by=/etc/apt/trusted.gpg.d/spotify.gpg] http://repository.spotify.com stable non-free:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/spotify.list

spotify-client:
  pkg.installed

{% for key, user in pillar.get('users', {}).items() %}
/home/{{ key }}/.config/regolith3/i3/config.d/50_spotify:
  file.managed:
    - contents: |
        assign [class="Spotify"] $ws8
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644
{% endfor %}
