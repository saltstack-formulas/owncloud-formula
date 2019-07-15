{%- from "owncloud/map.jinja" import owncloud with context %}

{%- set apcu = owncloud.get('apcu', {}) %}
{%- if apcu.get('enable', False) %}
owncloud_apcu_pkg:
  pkg.installed:
    - name: {{ apcu.pkg }}
{%- endif %}
