{% from "owncloud/map.jinja" import owncloud with context %}

owncloud-apache-php:
  pkg.installed:
    - pkgs:
      - apache2
      - php
      - php-gd
      - php-xml
  service.running:
    - name: apache2
    - watch:
      - pkg: owncloud-apache-php
      - pkg: {{ owncloud.pkg }}

