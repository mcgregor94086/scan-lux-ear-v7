#!/usr/bin/env bash
set -euo pipefail

# Allow running from repo root OR from v7/
if [[ -f "v7/index.html" ]]; then
  F="v7/index.html"
elif [[ -f "index.html" && -d "app" ]]; then
  F="index.html"
else
  echo "ℹ️  No v7/index.html (or root index.html+app) found. Nothing to verify."
  exit 0
fi

fail=0

loader_count=$(grep -c 'maps.googleapis.com/maps/api/js' "$F" || true)
if [[ "$loader_count" -ne 1 ]]; then
  echo "❌ $F must contain exactly ONE Google Maps loader (found $loader_count)."
  fail=1
fi

cb_count=$(grep -c 'callback=initMap' "$F" || true)
if [[ "$cb_count" -ne 0 ]]; then
  echo "❌ Remove callback=initMap from Google Maps URL."
  fail=1
fi

if ! grep -q 'data-lock="LuxEarMapsLoader"' "$F"; then
  echo '❌ data-lock="LuxEarMapsLoader" missing on loader tag.'
  fail=1
fi

mods=$(grep -n 'type="module"' "$F" || true)
echo "$mods" | grep -q 'app/main.js'     || { echo "❌ module app/main.js missing."; fail=1; }
echo "$mods" | grep -q 'app/map-init.js' || { echo "❌ module app/map-init.js missing."; fail=1; }

if [[ "$fail" -ne 0 ]]; then
  echo "🔒 Maps loader verification FAILED."
  exit 1
fi
echo "✅ Maps loader verification passed."
