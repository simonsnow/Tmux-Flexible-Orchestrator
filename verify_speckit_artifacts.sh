#!/usr/bin/env bash

# verify_speckit_artifacts.sh: Verify existence of Spec Kit artifacts for a feature
#
# Usage:
#   ./verify_speckit_artifacts.sh <feature-specs-dir>

FEATURE_DIR=${1?Usage: $0 <feature-specs-dir>}

files=(spec.md plan.md tasks.md)
missing=()

for f in "${files[@]}"; do
  if [[ ! -f "$FEATURE_DIR/$f" ]]; then
    missing+=("$f")
  fi
done

if [[ ${#missing[@]} -gt 0 ]]; then
  echo "Missing artifact(s) in $FEATURE_DIR: ${missing[*]}"
  exit 1
fi

echo "All artifacts present in $FEATURE_DIR: ${files[*]}"
exit 0