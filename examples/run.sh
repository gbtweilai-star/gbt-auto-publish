#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_auto_publish info
PYTHONPATH=src python -m gbt_auto_publish check --payload '{}'
PYTHONPATH=src python -m gbt_auto_publish run   --payload '{}'
