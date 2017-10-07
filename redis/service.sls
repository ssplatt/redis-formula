# -*- coding: utf-8 -*-
# vim: ft=sls
# Manage service for service redis
{%- from "redis/map.jinja" import redis with context %}

{% if redis.install_from == "package" %}
redis_service:
 service.{{ redis.service.state }}:
   - name: {{ redis.service.name }}
   - enable: {{ redis.service.enable }}
   - watch:
     - file: redis_config

{% if redis.sentinel is defined and redis.sentinel.enabled %}
redis_sentinel_service:
  service.{{ redis.sentinel.service.state }}:
    - name: {{ redis.sentinel.service.name }}
    - enable: {{ redis.sentinel.service.enable }}
    - watch:
      - file: redis_sentinel_config
{% endif %}
{% endif %}