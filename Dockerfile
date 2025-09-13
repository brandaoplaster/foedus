# Use Elixir official image
FROM elixir:1.15.7-alpine AS base

# Install build dependencies
RUN apk add --no-cache \
    build-base \
    git \
    postgresql-client \
    inotify-tools \
    curl \
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

#############################################
# Dependencies stage - for caching
#############################################
FROM base AS deps

# Copy mix files first for better caching
COPY --chown=elixir:elixir mix.exs mix.lock ./

# Install dependencies
RUN mix deps.get

#############################################
# Development stage
#############################################
FROM deps AS development

# Copy scripts first (they change less frequently)
COPY --chown=elixir:elixir scripts/ ./scripts/

# Make ALL scripts executable - FIX AQUI
RUN find ./scripts -type f -name "*.sh" -exec chmod +x {} \;

# Copy rest of application code
COPY --chown=elixir:elixir . .

# Compile dependencies only (code will be compiled by script)
RUN mix deps.compile

# Default command will be overridden by docker-compose
CMD ["mix", "phx.server"]

#############################################
# Production stage (for future use)
#############################################
FROM deps AS production

ENV MIX_ENV=prod

# Copy application code
COPY --chown=elixir:elixir . .

# Compile application
RUN mix deps.compile && \
    mix compile

# Create release
RUN mix release

CMD ["_build/prod/rel/foedus/bin/foedus", "start"]