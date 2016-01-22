#!/bin/bash

# Note: We use thin, because webrick attempts to do a reverse dns lookup on every request
# which slows the service down big time.  There is a setting to override this, but sinatra
# does not allow server specific settings to be passed down.
if [ -n "$VIRTUAL_HOST" ]
then
  exec fake_sqs --bind 0.0.0.0 --hostname $VIRTUAL_HOST --database=/messages/sqs/database.yml --port 9494 --server thin
else
  exec fake_sqs --bind 0.0.0.0 --database=/messages/sqs/database.yml --port 9494 --server thin
fi
