#!/usr/bin/env bash
set -euo pipefail

# Rebuild script for dagger/dagger
# Runs on existing source tree (no clone). Installs deps, runs pre-build steps, builds.
# Run from the docs/ directory of the checked-out repo.

# --- Node version ---
# Docusaurus 3.9.2 requires Node 20+
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    # shellcheck source=/dev/null
    . "$NVM_DIR/nvm.sh"
    nvm use 20 2>/dev/null || nvm install 20
fi
echo "[INFO] Using Node $(node --version)"

# --- Package manager: Yarn classic v1 ---
if ! command -v yarn &>/dev/null; then
    echo "[INFO] Installing yarn..."
    npm install -g yarn
fi
echo "[INFO] Yarn version: $(yarn --version)"

# --- Dependencies ---
yarn install --frozen-lockfile

# --- Build ---
yarn build

echo "[DONE] Build complete."
