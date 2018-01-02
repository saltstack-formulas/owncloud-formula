{% from "owncloud/map.jinja" import owncloud with context %}

owncloud-mysql-server:
  pkg.installed:
    - name: mysql-server
    - require_in:
      - service: owncloud-mysql-server
      - mysql_user: {{ owncloud.db_user }}
  service.running:
    - name: mysql
    - watch:
      - pkg: owncloud-mysql-server
