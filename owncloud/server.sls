{% from "owncloud/map.jinja" import owncloud with context %}

include:
  - owncloud.server-repo

install-owncloud-server:
  pkg.latest:
    - name: {{ owncloud.pkg }}
    - refresh: True
    
autoconfig-owncloud-server:
  file.managed:
    - template: jinja
    - name: /var/www/owncloud/config/autoconfig.php
    - source: salt://owncloud/files/autoconfig.php.jinja
    - user: www-data
    - group: www-data
