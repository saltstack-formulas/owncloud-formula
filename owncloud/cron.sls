{% from "owncloud/map.jinja" import owncloud with context %}

owncloud-cron:
  cron.present:
    - user: {{ owncloud.webserver_user }}
    - minute: '*/15'
    - name: {{ owncloud.php_path }} {{ owncloud.base_dir }}/{{ owncloud.cron_command }}
    - identifier: owncloud_cron
