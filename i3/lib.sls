{% macro gsettings(user, uid, path, key, value, regex) -%}
gsettings set {{ path }} {{ key }} {{ value }}:
  cmd.run:
    - env:
      - DBUS_SESSION_BUS_ADDRESS: unix:path=/run/user/{{ uid }}/bus
    - cwd: /
    - user: {{ user }}
    - unless: gsettings get {{ path }} {{ key }} | grep -q {{ regex }}
{%- endmacro %}
