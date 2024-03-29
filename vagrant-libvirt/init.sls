vagrant-packages:
  pkg.installed:
    - pkgs:
      - vagrant
      - ruby-libvirt
      - augeas-lenses
      - libaugeas0
      - libnetcf1
      - libvirt-daemon
      - libvirt-dev
      - libvirt0
      - libxen-dev

kvm-packages:
  pkg.installed:
    - pkgs:
      - qemu
      - libvirt-daemon-system
      - libvirt-clients
      - ebtables
      - dnsmasq-base
      - virt-manager
    - require:
      - pkg: vagrant-packages

libvirtd:
  service.running:
    - enable: True
    - require:
      - pkg: kvm-packages

vagrant-libvirt-packages:
  pkg.installed:
    - pkgs:
      - libxslt1-dev
      - libxml2-dev
      - libvirt-dev
      - zlib1g-dev
      - ruby-dev
    - require:
      - pkg: vagrant-packages
      - pkg: kvm-packages

libvirt:
  group.present:
    - system: True
    - members: {{ pillar.get('users', {}) }}

{% for user in pillar.get('users', {}) %}
vagrant plugin install vagrant-libvirt for {{ user }}:
  cmd.run:
    - runas: {{ user }}
    - require:
      - pkg: vagrant-packages
      - pkg: kvm-packages
      - pkg: vagrant-libvirt-packages
    - unless: vagrant plugin list | grep -q vagrant-libvirt && true || false
{% endfor %}
