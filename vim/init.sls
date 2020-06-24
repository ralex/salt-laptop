vim:
  pkg.installed

{% for user in pillar.get('users', {}) %}
/home/{{ user }}/.vim/autoload/plug.vim:
  file.managed:
    - source: https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    - skip_verify: True
    - user: {{ user }}
{% endfor %}
