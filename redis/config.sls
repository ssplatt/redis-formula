# -*- coding: utf-8 -*-
# vim: ft=sls
# How to configure redis
{%- from "redis/map.jinja" import redis with context %}

{% if redis.install_from == "package" %}
redis_config:
  file.managed:
    - name: /etc/redis/redis.conf
    - source: salt://redis/files/redis.conf.j2
    - user: root
    - group : root
    - mode: 0644
    - template: jinja

  {% if redis.sentinel is defined and redis.sentinel.enabled %}
redis_sentinel_config:
  file.managed:
    - name: /etc/redis/sentinel.conf
    - source: salt://redis/files/sentinel.conf.j2
    - user: redis
    - group : redis
    - mode: 0640
    - template: jinja
    
redis_sentinel_default_config:
  file.managed:
    - name: /etc/default/redis-sentinel
    - source: salt://redis/files/sentinel_default.j2
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
  {% endif %}
{% endif %}
