#!/usr/bin/env bash
set -eu

ENVIRONMENT=${1}

FILES=$(find .autopilot/${ENVIRONMENT} -type f)

# Interpolate all the templates first as a validation step
for i in $FILES; do
  CFG="$(erb $i)"
done

# Apply the configs
for i in $FILES; do
  CFG="$(erb $i)"
  if [[ ! -z "${CFG}" ]]; then
    echo "${CFG}" | kubectl apply -f -
  fi
done
