deb [signed-by=/etc/apt/keyrings/spotify.gpg] http://repository.spotify.com stable non-free:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/spotify.list
    - key_url: https://download.spotify.com/debian/pubkey_0D811D58.gpg
    - aptkey: False

spotify-client:
  pkg.installed
