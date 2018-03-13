FROM ruby:2.2-alpine

COPY Gemfile Gemfile.lock /

RUN apk add --no-cache --virtual .ruby-builddeps \
      autoconf \
      g++ \
      git \
      make \
    && bundle install \
    && apk add --no-cache --virtual .ruby-rundeps \
      libstdc++ \
    && apk del .ruby-builddeps

RUN adduser -u 1000 -D -H docker \
  && mkdir -p /messages/sqs \
  && chown docker /messages/sqs
USER docker

COPY start.sh /start.sh

VOLUME /sqs
EXPOSE 9494

# Note: We use thin, because webrick attempts to do a reverse dns lookup on every request
# which slows the service down big time.  There is a setting to override this, but sinatra
# does not allow server specific settings to be passed down.
CMD /start.sh
