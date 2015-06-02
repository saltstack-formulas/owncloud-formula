include:
  - owncloud.python-mysqldb

mysql-requirements:
  pkg.installed:
    - pkgs:
      - mysql-server
      - mysql-client
    - require_in:
      - service: mysql
      - mysql_user: {{ salt['pillar.get']('owncloud:owncloud_user', '') }}

mysql:
  service.running:
    - watch:
      - pkg: mysql-requirements

owncloud-local:
  mysql_user.present:
    - name: {{ salt['pillar.get']('owncloud:owncloud_user', '') }}
    - host: localhost
    - password: {{ salt['pillar.get']('owncloud:owncloud_password', '') }}
    - require:
      - pkg: python-mysqldb
      - pkg: mysql-requirements
      - service: mysql

ownclouddb:
  mysql_database.present:
    - name: {{ salt['pillar.get']('owncloud:owncloud_database', '') }}
    - require:
      - mysql_user: {{ salt['pillar.get']('owncloud:owncloud_user', '') }}
      - pkg: python-mysqldb
  mysql_grants.present:
    - grant: all privileges
    - database:  {{ salt['pillar.get']('owncloud:owncloud_database', '') }}.*
    - host: localhost
    - user: {{ salt['pillar.get']('owncloud:owncloud_user', '') }}
    - require:
      - mysql_database: {{ salt['pillar.get']('owncloud:owncloud_database', '') }}
      - pkg: python-mysqldb
      - service: mysql

