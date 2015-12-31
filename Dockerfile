FROM ruby:2.2

RUN gem install thin fake_sqs

RUN useradd -u 1000 -M docker \
  && mkdir -p /messages/sqs \
  && chown docker /messages/sqs
USER docker

VOLUME /sqs
EXPOSE 9494

# Note: We use thin, because webrick attempts to do a reverse dns lookup on every request
# which slows the service down big time.  There is a setting to override this, but sinatra
# does not allow server specific settings to be passed down.
CMD fake_sqs --bind 0.0.0.0 --database=/messages/sqs/database.yml --port 9494 --server thin
