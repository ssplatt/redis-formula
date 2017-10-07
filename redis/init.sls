# -*- coding: utf-8 -*-
# vim: ft=sls
# Init redis
{%- from "redis/map.jinja" import redis with context %}

{%- if redis.enabled %}
include:
  - redis.install
  - redis.config
  - redis.service
{%- else %}
'redis-formula disabled':
  test.succeed_without_changes
{%- endif %}
