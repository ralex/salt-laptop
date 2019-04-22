{% macro gsettings(user, path, key, value, regex) -%}
gsettings set {{ path }} {{ key }} {{ value }}:
  cmd.run:
    - cwd: /
    - user: {{ user }}
    - unless: gsettings get {{ path }} {{ key }} | grep -q {{ regex }}
# TODO: Does "dconf update" need to be ran?
{%- endmacro %}
