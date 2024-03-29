#!/bin/bash
#
if [ -z "$REDIS_MASTER_PORT_6379_TCP_ADDR" ]; then
    echo "REDIS_MASTER_PORT_6379_TCP_ADDR not defined. Did you run with -link?";
    exit 7;
fi
# exec allows redis-server to receive signals for clean shutdown
#
exec /usr/local/bin/redis-server --slaveof $REDIS_MASTER_PORT_6379_TCP_ADDR $REDIS_MASTER_PORT_6379_TCP_PORT $*
