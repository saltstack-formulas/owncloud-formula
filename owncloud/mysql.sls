{% from "owncloud/map.jinja" import owncloud with context %}

include:
  - owncloud.python-mysqldb

owncloud-database-user:
  mysql_user.present:
    - name: {{ owncloud.db_user }}
    - host: localhost
    # Make this thing fail if no password is set!
    {% set password = salt['pillar.get']('owncloud:owncloud_password', False) %}
    {% if not password %}
        {{ salt.test.exception("Pillar owncloud:owncloud_password must be set!") }}
    {% endif %}
    - password: {{ password }}
    {% set root_password = salt['pillar.get']('owncloud:mysql_root_password', False) %}
    {% if not root_password %}
      - connection_user: root
      - connection_password: {{ root_password }}
    {% endif %}
    - require:
      - pkg: python-mysqldb
      - pkg: owncloud-mysql-client
      - service: owncloud-mysql-server

owncloud-database:
  mysql_database.present:
    - name: {{ salt['pillar.get']('owncloud:owncloud_database', '') }}
    - require:
      - mysql_user: owncloud-database-user
      - pkg: python-mysqldb
  mysql_grants.present:
    - grant: all privileges
    - database:  {{ owncloud.db_name }}.*
    - host: localhost
    - user: {{ owncloud.db_user }}
    - require:
      - mysql_database: owncloud-database
      - pkg: python-mysqldb
      - service: owncloud-mysql-server

