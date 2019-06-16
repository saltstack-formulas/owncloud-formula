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
    - name: {{ owncloud.base_dir }}/config/autoconfig.php
    - source: salt://owncloud/files/autoconfig.php.jinja
    - user: {{ owncloud.webserver_user }}
    - group: {{ owncloud.webserver_group }}

salt_managed_config-owncloud-server:
  file.managed:
    - template: jinja
    - name: {{ owncloud.base_dir }}/config/salt_managed.config.php
    - source: salt://owncloud/files/salt_managed.config.php.jinja
    - user: {{ owncloud.webserver_user }}
    - group: {{ owncloud.webserver_group }}
    - context:
        salt_managed_config: {{ owncloud.get('salt_managed_config', {})  | json }}
