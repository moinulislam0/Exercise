#!/bin/zsh

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
export GRADLE_USER_HOME="$ROOT_DIR/.gradle-local"

cd "$ROOT_DIR"
flutter build apk --release
