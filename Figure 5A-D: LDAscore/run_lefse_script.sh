set -euo pipefail

INPUT_LIST="$1"
LDA_VALUES_CSV="$2"
OUTPUT_ROOT="$3"
PATCHED_PLOT_SCRIPT="$4"

DPI=300

IFS=',' read -r -a LDA_VALUES <<< "$LDA_VALUES_CSV"

mkdir -p "$OUTPUT_ROOT/formatted-inputs"

if [[ ! -f "$INPUT_LIST" ]]; then
    echo "ERROR: input list not found inside container: $INPUT_LIST" >&2
    exit 1
fi

if [[ ! -f "$PATCHED_PLOT_SCRIPT" ]]; then
    echo "ERROR: patched plotting script not found inside container: $PATCHED_PLOT_SCRIPT" >&2
    exit 1
fi

if [[ ! -x "$PATCHED_PLOT_SCRIPT" ]]; then
    echo "ERROR: patched plotting script is not executable: $PATCHED_PLOT_SCRIPT" >&2
    echo "Try: chmod +x $PATCHED_PLOT_SCRIPT" >&2
    exit 1
fi

# helper to set up env the same way as the original script,
# as well as adding the original script dir to the python env
# so that lefse itself is visible even though the patched
# script is in /data
# see /home/linuxbrew/.linuxbrew/bin/plot_res.py
LEFSE_LIBEXEC="/home/linuxbrew/.linuxbrew/Cellar/lefse/1.0.0-dev-e3cabe9/libexec"
LEFSE_BIN="$LEFSE_LIBEXEC/bin"

LEFSE_PYTHONPATH="${LEFSE_BIN}:${LEFSE_LIBEXEC}/lib64/python2.7/site-packages:${LEFSE_LIBEXEC}/lib/python2.7/site-packages:/home/linuxbrew/.linuxbrew/lib/python2.7/site-packages"
LEFSE_R_LIBS="${LEFSE_LIBEXEC}/R/library"

run_patched_plot_res() {
    local res_file="$1"
    local png_file="$2"

    PYTHONPATH="$LEFSE_PYTHONPATH" \
    R_LIBS="$LEFSE_R_LIBS" \
    "$PATCHED_PLOT_SCRIPT" \
        "$res_file" \
        "$png_file" \
        --dpi "$DPI"
}

while IFS= read -r INPUT || [[ -n "${INPUT:-}" ]]; do
    # Trim leading/trailing whitespace.
    INPUT="${INPUT#"${INPUT%%[![:space:]]*}"}"
    INPUT="${INPUT%"${INPUT##*[![:space:]]}"}"

    # Skip blank lines and comments.
    [[ -z "$INPUT" ]] && continue
    [[ "$INPUT" =~ ^# ]] && continue

    if [[ ! -f "$INPUT" ]]; then
        echo "ERROR: listed input file not found inside container: $INPUT" >&2
        exit 1
    fi

    BASENAME="$(basename "$INPUT")"
    BASENAME="${BASENAME%.tsv}"

    FORMATTED_INPUT="$OUTPUT_ROOT/formatted-inputs/${BASENAME}.in"

    echo "Processing input: $INPUT"
    echo "Formatted input:  $FORMATTED_INPUT"

    format_input.py \
        "$INPUT" \
        "$FORMATTED_INPUT" \
        -c 1 \
        -s "-1" \
        -u 2 \
        -o 1000000

    for LDA in "${LDA_VALUES[@]}"; do
        # Remove incidental whitespace around comma-separated values.
        LDA="${LDA//[[:space:]]/}"
        [[ -z "$LDA" ]] && continue

        OUTDIR="$OUTPUT_ROOT/lda-${LDA}/${BASENAME}"
        RES_FILE="$OUTDIR/${BASENAME}.res"
        PNG_FILE="$OUTDIR/final-colors.${BASENAME}.lda-${LDA}.png"

        mkdir -p "$OUTDIR"

        echo "  LDA threshold: $LDA"
        echo "  Results:       $RES_FILE"
        echo "  Plot:          $PNG_FILE"

        run_lefse.py \
            "$FORMATTED_INPUT" \
            "$RES_FILE" \
            -l "$LDA"

        run_patched_plot_res "$RES_FILE" "$PNG_FILE"
    done

    echo
done < "$INPUT_LIST"

echo "All LEfSe jobs complete."
