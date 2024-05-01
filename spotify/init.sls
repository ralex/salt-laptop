deb [signed-by=/etc/apt/trusted.gpg.d/spotify.gpg] http://repository.spotify.com stable non-free:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/spotify.list
    - key_url: https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg
    - aptkey: False

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
