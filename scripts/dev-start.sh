#!/bin/sh

set -e

echo "🚀 Starting Foedus development server..."

# Verifica se as dependências precisam ser instaladas
if [ ! -d "deps" ] || [ "mix.lock" -nt "deps/.mix_deps_timestamp" ]; then
  echo "📦 Installing/updating dependencies..."
  mix deps.get
  touch deps/.mix_deps_timestamp
fi

# Verifica se precisa compilar
if [ ! -d "_build" ] || find lib config -newer _build/dev -print -quit | grep -q .; then
  echo "🔨 Compiling application..."
  mix compile
fi

# Setup do banco (apenas se necessário)
echo "🗃️ Setting up database..."
mix ecto.create --quiet || true
mix ecto.migrate --quiet || true

echo "✅ Starting Phoenix server..."
exec mix phx.server