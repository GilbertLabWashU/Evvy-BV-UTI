#!/usr/bin/env bash
set -euo pipefail

LEFSE_LIBEXEC="/home/linuxbrew/.linuxbrew/Cellar/lefse/1.0.0-dev-e3cabe9/libexec"
LEFSE_BIN="$LEFSE_LIBEXEC/bin"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
PATCHED_PLOT_SCRIPT="${PATCHED_PLOT_SCRIPT:-$SCRIPT_DIR/patched_plot_res.py}"

if [[ ! -f "$PATCHED_PLOT_SCRIPT" ]]; then
    echo "ERROR: patched plotting script not found: $PATCHED_PLOT_SCRIPT" >&2
    exit 1
fi

if [[ ! -x "$PATCHED_PLOT_SCRIPT" ]]; then
    echo "ERROR: patched plotting script is not executable: $PATCHED_PLOT_SCRIPT" >&2
    echo "Try: chmod +x $PATCHED_PLOT_SCRIPT" >&2
    exit 1
fi

PYTHONPATH="${LEFSE_BIN}:${LEFSE_LIBEXEC}/lib64/python2.7/site-packages:${LEFSE_LIBEXEC}/lib/python2.7/site-packages:/home/linuxbrew/.linuxbrew/lib/python2.7/site-packages" \
R_LIBS="${LEFSE_LIBEXEC}/R/library" \
exec "$PATCHED_PLOT_SCRIPT" "$@"
