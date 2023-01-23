deb [signed-by=/etc/apt/trusted.gpg.d/spotify.gpg] http://repository.spotify.com stable non-free:
  pkgrepo.managed:
    - file: /etc/apt/sources.list.d/spotify.list
    - key_url: https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg
    - aptkey: False

spotify-client:
  pkg.installed
