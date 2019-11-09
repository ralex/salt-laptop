deb http://repository.spotify.com stable non-free:
  pkgrepo.managed:
    - humanname: Spotify
    - file: /etc/apt/sources.list.d/spotify.list
    - key_url: https://download.spotify.com/debian/pubkey.gpg

spotify-client:
  pkg.installed
