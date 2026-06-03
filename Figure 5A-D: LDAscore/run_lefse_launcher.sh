#!/usr/bin/env bash
set -euo pipefail

usage() {
    cat <<'EOF'
Usage:
  run_lefse_publication.sh \
    --input-list <list_of_inputs.txt> \
    --lda-values <comma_separated_LDA_values> \
    --output-root <output_dir> \
    [--project-dir <host_project_dir>] \
    [--plot-script <patched_plot_res.py>] \
    [--docker-image <image>]

Example:
  ./run_lefse_publication.sh \
    --input-list inputs/lefse_inputs.txt \
    --lda-values 2.0,2.5,3.0 \
    --output-root dpi-300-all-LDAs \
    --plot-script patched_plot_res.py

Notes:
  - project-dir is mounted into Docker as /data.
  - input-list should contain paths visible from inside /data:
      e.g. relative paths like inputs/table1.tsv
      or absolute container paths like /data/inputs/table1.tsv
EOF
}

INPUT_LIST=""
LDA_VALUES=""
OUTPUT_ROOT=""
PROJECT_DIR="$(pwd)"
PATCHED_PLOT_SCRIPT="patched_plot_res.py"
DOCKER_IMAGE="biobakery/lefse"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --input-list|-i)
            INPUT_LIST="$2"
            shift 2
            ;;
        --lda-values|-l)
            LDA_VALUES="$2"
            shift 2
            ;;
        --output-root|-o)
            OUTPUT_ROOT="$2"
            shift 2
            ;;
        --project-dir|-m)
            PROJECT_DIR="$2"
            shift 2
            ;;
        --plot-script|-p)
            PATCHED_PLOT_SCRIPT="$2"
            shift 2
            ;;
        --docker-image)
            DOCKER_IMAGE="$2"
            shift 2
            ;;
        --help|-h)
            usage
            exit 0
            ;;
        *)
            echo "ERROR: unknown argument: $1" >&2
            usage >&2
            exit 1
            ;;
    esac
done

if [[ -z "$INPUT_LIST" || -z "$LDA_VALUES" || -z "$OUTPUT_ROOT" ]]; then
    echo "ERROR: --input-list, --lda-values, and --output-root are required." >&2
    usage >&2
    exit 1
fi

PROJECT_DIR="$(cd "$PROJECT_DIR" && pwd -P)"

host_path_for_check() {
    local path="$1"

    if [[ "$path" == /data/* ]]; then
        printf '%s\n' "$PROJECT_DIR/${path#/data/}"
    elif [[ "$path" == /* ]]; then
        printf '%s\n' "$path"
    else
        printf '%s\n' "$PROJECT_DIR/$path"
    fi
}

to_container_path() {
    local path="$1"

    if [[ "$path" == /data || "$path" == /data/* ]]; then
        printf '%s\n' "$path"
    elif [[ "$path" == "$PROJECT_DIR" ]]; then
        printf '/data\n'
    elif [[ "$path" == "$PROJECT_DIR"/* ]]; then
        printf '/data/%s\n' "${path#"$PROJECT_DIR"/}"
    elif [[ "$path" == /* ]]; then
        echo "ERROR: absolute path is outside project-dir and will not be visible in Docker: $path" >&2
        exit 1
    else
        printf '/data/%s\n' "$path"
        #printf '%s\n' "$path"
    fi
}

INPUT_LIST_HOST="$(host_path_for_check "$INPUT_LIST")"
PATCHED_PLOT_SCRIPT_HOST="$(host_path_for_check "$PATCHED_PLOT_SCRIPT")"

if [[ ! -f "$INPUT_LIST_HOST" ]]; then
    echo "ERROR: input list not found on host: $INPUT_LIST_HOST" >&2
    exit 1
fi

if [[ ! -f "$PATCHED_PLOT_SCRIPT_HOST" ]]; then
    echo "ERROR: patched plotting script not found on host: $PATCHED_PLOT_SCRIPT_HOST" >&2
    exit 1
fi

INPUT_LIST_IN_CONTAINER="$(to_container_path "$INPUT_LIST")"
PATCHED_PLOT_SCRIPT_IN_CONTAINER="$(to_container_path "$PATCHED_PLOT_SCRIPT")"
OUTPUT_ROOT_IN_CONTAINER="$(to_container_path "$OUTPUT_ROOT")"

docker run --rm \
    -v "$PROJECT_DIR:/data" \
    -w /data \
    "$DOCKER_IMAGE" \
    bash /data/run_lefse_script.sh \
        "$INPUT_LIST_IN_CONTAINER" \
        "$LDA_VALUES" \
        "$OUTPUT_ROOT_IN_CONTAINER" \
        "$PATCHED_PLOT_SCRIPT_IN_CONTAINER"
