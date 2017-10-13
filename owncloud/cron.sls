{% from "owncloud/map.jinja" import owncloud with context %}

owncloud-cron:
  cron.present:
    - user: {{ owncloud.webserver_user }}
    - minute: '*/15'
    - name: {{ owncloud.php_path }} {{ owncloud.base_dir }}/cron.php
    - identifier: owncloud_cron
