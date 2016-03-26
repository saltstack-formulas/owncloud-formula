{% from "owncloud/map.jinja" import owncloud with context %}

include:
  - owncloud.mysql
  - owncloud.repo

apache2-stuff:
  pkg.installed:
    - pkgs:
      - apache2
      - php5
      - php5-gd
  service.running:
    - name: apache2
    - watch:
      - pkg: apache2-stuff
      - pkg: {{ owncloud.pkg }}


install-owncloud:
  pkg.installed:
    - name: {{ owncloud.pkg }}
    - refresh: True
    
autoconfig-owncloud:
  file.managed:
    - template: jinja
    - name: /var/www/owncloud/config/autoconfig.php
    - source: salt://owncloud/autoconfig.php.jinja
    - user: www-data
    - group: www-data
