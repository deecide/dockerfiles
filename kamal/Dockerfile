FROM ruby:alpine

RUN apk add --no-cache bash git gpg openssh build-base docker curl

RUN mkdir -p ~/.ssh && chmod 700 ~/.ssh
RUN echo '#!/bin/sh\n\
eval $(ssh-agent -s)\n\
exec "$@"' > /entrypoint.sh && chmod +x /entrypoint.sh

ARG KAMAL_VERSION
RUN gem install kamal -v $KAMAL_VERSION

RUN mkdir -p /myapp
WORKDIR /myapp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["sh"]