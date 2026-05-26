#!/bin/bash
source .env 2>/dev/null || export TMDB_API_KEY=""

if [ -z "$TMDB_API_KEY" ]; then
  echo "Error: TMDB_API_KEY not found in .env"
  exit 1
fi

if command -v fvm &>/dev/null && [ -f ".fvmrc" ]; then
  FLUTTER_CMD="fvm flutter"
else
  FLUTTER_CMD="flutter"
fi

echo "Usando: $($FLUTTER_CMD --version | head -1)"
echo ""
echo "Dispositivos disponibles:"
$FLUTTER_CMD devices
echo ""

$FLUTTER_CMD run \
  --dart-define=TMDB_API_KEY="$TMDB_API_KEY" \
  "$@"