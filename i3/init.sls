{% from "i3/lib.sls" import gsettings %}

i3-additional-packages:
  pkg:
    - pkgs:
      - arc-theme

{% for user in pillar.get('users', {}) %}
{# Change Windows buttons layout #}
{{ gsettings(user, "org.gnome.shell.overrides", "button-layout", ':minimize,maximize,close', "':minimize,maximize,close'") }}
{# Change Gnome Shell user theme #}
{{ gsettings(user, "org.gnome.shell.extensions.user-theme", "name", "Arc", '^Arc$') }}
{% endfor %}
