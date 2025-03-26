FROM n8nio/n8n:latest

USER root
RUN apk add --no-cache ruby build-base postgresql-dev ruby-dev postgresql-client

USER node
RUN gem install pg
