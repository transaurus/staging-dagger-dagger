#!/bin/bash
# Generated setup script for: https://github.com/dagger/dagger
# Docusaurus 3.9.2, Yarn v1 (classic), Node 20+

set -e

REPO_URL="https://github.com/dagger/dagger"
BRANCH="main"

echo "[INFO] Cloning repository..."
if [ -d "source-repo" ]; then
    rm -rf source-repo
fi

git clone --depth 1 --branch "$BRANCH" "$REPO_URL" source-repo
cd source-repo/docs

echo "[INFO] Node version: $(node -v)"
echo "[INFO] NPM version: $(npm -v)"

# Ensure yarn (classic v1) is available
if ! command -v yarn &> /dev/null; then
    echo "[INFO] Installing yarn..."
    npm install -g yarn
fi
echo "[INFO] Yarn version: $(yarn --version)"

echo "[INFO] Installing dependencies..."
yarn install --frozen-lockfile

echo "[INFO] Running write-translations..."
yarn write-translations

echo "[INFO] Verifying i18n output..."
if [ -d "i18n" ]; then
    find i18n -type f -name "*.json" | head -20
    COUNT=$(find i18n -type f -name "*.json" | wc -l)
    echo "[INFO] Generated $COUNT JSON files"
else
    echo "[ERROR] i18n directory not found"
    exit 1
fi

echo "[INFO] Running build..."
yarn build

echo "[INFO] Verifying build output..."
if [ -d "build" ]; then
    BUILD_FILES=$(find build -type f | wc -l)
    echo "[INFO] build/ directory contains $BUILD_FILES files"
else
    echo "[ERROR] build/ directory not found"
    exit 1
fi

echo "[INFO] Setup completed successfully!"
