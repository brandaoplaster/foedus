# Use Elixir official image
FROM elixir:1.15.7-alpine

# Install build dependencies
RUN apk add --no-cache \
    build-base \
    git \
    postgresql-client \
    inotify-tools \
    sudo

# Create user with same UID/GID as host user
ARG USER_ID=1000
ARG GROUP_ID=1000
RUN addgroup -g ${GROUP_ID} -S elixir && \
    adduser -u ${USER_ID} -S elixir -G elixir -s /bin/sh

# Set work directory
WORKDIR /app

# Change ownership
RUN chown -R elixir:elixir /app

# Switch to elixir user
USER elixir

# Install Hex and Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Copy mix files (for dependency caching)
COPY --chown=elixir:elixir mix.exs mix.lock ./

# Install dependencies
RUN mix deps.get

# Copy rest of project files
COPY --chown=elixir:elixir . .

# Update dependencies (in case mix.lock changed)
RUN mix deps.get

# Compile project
RUN mix compile

# Default command
CMD ["mix", "phx.server"]
