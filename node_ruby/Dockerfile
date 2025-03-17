ARG NODE_VERSION
ARG RUBY_VERSION
ARG SUFFIX=''

FROM node:${NODE_VERSION}${SUFFIX} AS node
FROM ruby:${RUBY_VERSION}${SUFFIX}

# Base packages
RUN apt-get update -qq && apt-get install -qq --no-install-recommends curl gnupg2

# Node
COPY --from=node /usr/local/share /usr/local/share
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin
COPY --from=node /opt /opt

# Builder packages
ARG BUILDER=false
RUN if [ "$BUILDER" = "true" ]; then \
    apt-get install -qq --no-install-recommends git autoconf build-essential postgresql-common imagemagick \
    && /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -y \
    && apt-get install -qq --no-install-recommends postgresql-client-17 libpq-dev; \
  fi

# Clean up
RUN if [ "$BUILDER" = "false" ]; then \
    apt-get clean \
    && rm -rf /var/lib/apt/lists/*; \
  fi
