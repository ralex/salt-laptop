{% from "i3/lib.sls" import gsettings %}

i3-additional-packages:
  pkg.installed:
    - pkgs:
      - arc-theme

{% for user in pillar.get('users', {}) %}
{# Change Windows buttons layout #}
{{ gsettings(user, "org.gnome.desktop.wm.preferences", "button-layout", 'close,maximize,minimize:', "'close,maximize,minimize:'") }}
{# Change Gnome Shell user theme #}
{{ gsettings(user, "org.gnome.shell.extensions.user-theme", "name", "Arc-Darker", '^Arc-Darker$') }}
{% endfor %}
