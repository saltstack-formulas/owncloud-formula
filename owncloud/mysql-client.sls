{% from "owncloud/map.jinja" import owncloud with context %}

owncloud-mysql-client:
  pkg.installed:
    - name: mysql-client
    - require_in:
      - mysql_user: {{ owncloud.db_user }}

