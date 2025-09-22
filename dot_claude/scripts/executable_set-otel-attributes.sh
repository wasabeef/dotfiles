#!/bin/bash
# 動的にホスト名を含む OTEL_RESOURCE_ATTRIBUTES を設定

HOSTNAME=$(hostname)
export OTEL_RESOURCE_ATTRIBUTES="service.name=claude-code,service.version=1.0.0,host.name=${HOSTNAME}"