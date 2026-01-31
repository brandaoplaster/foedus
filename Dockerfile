# ============================================
# Stage 0: Common base (system dependencies)
# ============================================
FROM elixir:1.15.7-alpine AS base

RUN apk add --no-cache \
    build-base \
    git \
    openssh-client \
    postgresql-dev \
    && rm -rf /var/cache/apk/*

WORKDIR /app
RUN mix do local.hex --force, local.rebar --force

# ============================================
# Stage 1: Dependencies (better caching)
# ============================================
FROM base AS deps

# Copy only dependency files first
COPY mix.exs mix.lock ./
RUN --mount=type=ssh mix deps.get --only prod

# ============================================
# Stage 2: Development
# ============================================
FROM base AS dev

# Add only what is specific for development
RUN apk add --no-cache nodejs npm inotify-tools \
    && rm -rf /var/cache/apk/*

COPY mix.exs mix.lock ./
COPY config config
RUN --mount=type=ssh mix deps.get

# The rest will be set up via volume in Compose

# ============================================
# Stage 3: Build (production)
# ============================================
FROM base AS build

# Add only build-specific files
RUN apk add --no-cache nodejs npm \
    && rm -rf /var/cache/apk/*

ARG mix_env=prod
WORKDIR /app

# 1. Dependencies first (better caching)
COPY mix.exs mix.lock ./
RUN --mount=type=ssh mix deps.get --only $mix_env

# 2. Configurations
COPY config config

# 3. Source code
COPY lib lib
COPY priv priv
COPY scripts scripts

# 4. Assets
COPY assets assets
RUN if [ -f "assets/package.json" ]; then \
    cd assets && npm ci --omit=dev && \
    (npm run deploy || npm run build || true); \
    fi

# 5. Compile and make release
RUN MIX_ENV=$mix_env mix compile
RUN MIX_ENV=$mix_env mix release

# ============================================
# Stage 4: Runtime (production – minimal image)
# ============================================
FROM alpine:3.20 AS app

RUN apk add --no-cache \
    openssl \
    ncurses-libs \
    libstdc++ \
    ca-certificates \
    && rm -rf /var/cache/apk/*

ARG mix_env=prod
WORKDIR /app

RUN addgroup -g 1000 -S appuser && \
    adduser -u 1000 -S appuser -G appuser && \
    chown -R appuser:appuser /app

USER appuser:appuser

COPY --from=build --chown=appuser:appuser /app/_build/${mix_env}/rel/sendwise ./
COPY --from=build --chown=appuser:appuser /app/scripts/start.sh ./start.sh

ENV HOME=/app \
    PATH=/app/bin:$PATH

CMD ["sh", "./start.sh"]
