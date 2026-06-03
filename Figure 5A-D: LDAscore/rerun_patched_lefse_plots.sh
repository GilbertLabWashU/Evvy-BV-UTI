#!/usr/bin/env bash
set -euo pipefail

usage() {
    cat <<'EOF'
Usage:
  rerun_patched_lefse_plots.sh <existing_output_root> [output_prefix]

Example:
  rerun_patched_lefse_plots.sh /data/dpi-300-all-LDAs revised-colors.

This finds all *.res files under existing_output_root and writes new PNGs
alongside them using the requested prefix.
EOF
}

if [[ $# -lt 1 || $# -gt 2 ]]; then
    usage >&2
    exit 1
fi

ROOT="$1"
PREFIX="${2:-rerun.}"
DPI=300

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
PLOT_WRAPPER="$SCRIPT_DIR/patched_plot_res_wrapper.sh"

if [[ ! -d "$ROOT" ]]; then
    echo "ERROR: output root does not exist: $ROOT" >&2
    exit 1
fi

if [[ ! -x "$PLOT_WRAPPER" ]]; then
    echo "ERROR: plot wrapper is not executable: $PLOT_WRAPPER" >&2
    echo "Try: chmod +x $PLOT_WRAPPER" >&2
    exit 1
fi

find "$ROOT" -type f -name '*.res' -print0 |
while IFS= read -r -d '' RES_FILE; do
    OUTDIR="$(dirname "$RES_FILE")"
    BASE="$(basename "$RES_FILE" .res)"
    PNG_FILE="$OUTDIR/${PREFIX}${BASE}.png"

    echo "Plotting:"
    echo "  input:  $RES_FILE"
    echo "  output: $PNG_FILE"

    "$PLOT_WRAPPER" \
        "$RES_FILE" \
        "$PNG_FILE" \
        --dpi "$DPI"
done

echo "Replotting complete."
