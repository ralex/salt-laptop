{% if salt['pillar.get']('github.com:token')|length %}
{% set curl_header = '-H "Authorization: token '~ salt['pillar.get']('github.com:token') ~'"' %}
{% else %}
{% set curl_header = '' %}
{% endif %}
{% if salt['pillar.get']('sony_headphone_client:version')|length %}
{% set rnnoise_version = salt['pillar.get']('sony_headphone_client:version', salt['cmd.run']('curl '~ curl_header ~' -sL -t2 "https://api.github.com/repos/werman/noise-suppression-for-voice/releases/latest" | jq -r ".tag_name"', python_shell=True)) %}
{% endif %}
{% if rnnoise_version is not defined or rnnoise_version == 'null' %}
{% set rnnoise_version = 'v1.03' %}
{% endif %}

lib-linux-rnnoise:
  archive.extracted:
    - name: /usr/local/lib
    - source: https://github.com/werman/noise-suppression-for-voice/releases/download/{{ rnnoise_version }}/linux-rnnoise.zip
    - skip_verify: True
    - enforce_toplevel: False
    - user: root
    - group: root

pipewire:
  pkg.installed

{% for key, user in pillar.get('users', {}).items() %}
/home/{{ key }}/.config/pipewire/pipewire.conf.d/99-input-denoising.conf:
  file.managed:
    - source: salt://pipewire/99-input-denoising.conf
    - makedirs: True
    - user: {{ user.uid }}
    - group: {{ user.gid }}
    - mode: 644

rnnoise-systemd-restart-pipewire:
  cmd.run:
   - name: systemctl restart --user pipewire.service
   - runas: {{ key }}
   - env:
     - DBUS_SESSION_BUS_ADDRESS: {{ 'unix:path=/run/user/' ~ user.uid ~ '/bus' }}
   - onchanges:
     - archive: lib-linux-rnnoise
     - file: /home/{{ key }}/.config/pipewire/pipewire.conf.d/99-input-denoising.conf
{% endfor %}
