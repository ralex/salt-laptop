deb http://repository.spotify.com stable non-free:
  pkgrepo.managed:
    - humanname: Spotify
    - file: /etc/apt/sources.list.d/spotify.list
    - key_url: https://download.spotify.com/debian/pubkey_0D811D58.gpg

spotify-client:
  pkg.installed
