{% from "owncloud/map.jinja" import owncloud with context %}

{% if grains['os_family'] == 'Debian' %}
owncloud-repo:
  pkgrepo.managed:
    - name: deb {{ owncloud.server_pkg_repo }}
    - file: {{ owncloud.server_repo_file }}
    - key_url: {{ owncloud.server_key_url }}
    - gpgcheck: 1
    - clean_file: True
{%- endif %}
