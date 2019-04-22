{% from "i3/lib.sls" import gsettings %}

i3-additional-packages:
  pkg.installed:
    - pkgs:
      - arc-theme

{% for user, params in pillar.get('users', {}) %}
{# Change Windows buttons layout #}
{{ gsettings(user, params['uid'], "org.gnome.desktop.wm.preferences", "button-layout", 'close,maximize,minimize:', "'close,maximize,minimize:'") }}
{# Change Gnome Shell user theme #}
{{ gsettings(user, params['uid'], "org.gnome.shell.extensions.user-theme", "name", "Arc-Darker", '^Arc-Darker$') }}
{% endfor %}
