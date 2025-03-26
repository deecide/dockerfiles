FROM n8nio/n8n:latest

USER root
RUN apk add --no-cache ruby libpq-dev build-base postgresql-dev ruby-dev

USER node

RUN gem install pg