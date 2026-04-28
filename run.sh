#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"

if [[ -f "${ROOT}/.env" ]]; then
  set -a
  # shellcheck disable=SC1091
  source "${ROOT}/.env"
  set +a
fi

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  exec python3 "${ROOT}/tibber_energy.py" "$@"
fi

if [[ -z "${TIBBER_ACCESS_TOKEN:-}" ]]; then
  echo "ERROR: Missing TIBBER_ACCESS_TOKEN environment variable." >&2
  echo "Set it in ${ROOT}/.env or export it, e.g.:" >&2
  echo "  export TIBBER_ACCESS_TOKEN=\"your_tibber_token\"" >&2
  exit 1
fi
exec python3 "${ROOT}/tibber_energy.py" "$@"
