include:
  - owncloud.python-mysqldb

mysql-requirements:
  pkg.installed:
    - pkgs:
      - mysql-server
      - mysql-client
    - require_in:
      - service: mysql
      - mysql_user: owncloud

mysql:
  service.running:
    - watch:
      - pkg: mysql-requirements

owncloud-local:
  mysql_user.present:
    - name: owncloud
    - host: localhost
    - password: {{ salt['pillar.get']('owncloud:owncloudpass', '') }}
    - require:
      - pkg: python-mysqldb
      - pkg: mysql-requirements
      - service: mysql

ownclouddb:
  mysql_database.present:
    - name: owncloud
    - require:
      - mysql_user: owncloud
      - pkg: python-mysqldb
  mysql_grants.present:
    - grant: all privileges
    - database: owncloud.*
    - host: localhost
    - user: owncloud
    - require:
      - mysql_database: owncloud
      - pkg: python-mysqldb
      - service: mysql

