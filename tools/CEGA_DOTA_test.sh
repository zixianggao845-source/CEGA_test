#!/usr/bin/env bash
set -euo pipefail

# Evaluate work_dirs/CEGA_DOTA/CEGA_DOTA.pth.
# Required environment variable: DOTA_ROOT
# Optional: CHECKPOINT, OUT_DIR, PYTHON

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG="${ROOT}/configs/strip_rcnn/CEGA_DOTA_config.py"
DOTA_ROOT="${DOTA_ROOT:?Set DOTA_ROOT to the split DOTA dataset root}"
CHECKPOINT="${CHECKPOINT:-${ROOT}/work_dirs/CEGA_DOTA/CEGA_DOTA.pth}"
OUT_DIR="${OUT_DIR:-${ROOT}/work_dirs/CEGA_DOTA_test}"
PYTHON="${PYTHON:-python}"
MODE="${1:-val}"

COMMON_CFG=(
    "data.val.ann_file=${DOTA_ROOT}/trainval/annfiles/"
    "data.val.img_prefix=${DOTA_ROOT}/trainval/images/"
    "data.test.ann_file=${DOTA_ROOT}/test/images/"
    "data.test.img_prefix=${DOTA_ROOT}/test/images/"
)

cd "${ROOT}"

if [[ ! -f "${CHECKPOINT}" ]]; then
    echo "Checkpoint not found: ${CHECKPOINT}" >&2
    exit 1
fi

mkdir -p "${OUT_DIR}"

case "${MODE}" in
    val)
        "${PYTHON}" tools/test.py "${CONFIG}" "${CHECKPOINT}" \
            --work-dir "${OUT_DIR}" \
            --out "${OUT_DIR}/CEGA_DOTA_val_results.pkl" \
            --eval mAP \
            --cfg-options "${COMMON_CFG[@]}"
        ;;
    submit)
        "${PYTHON}" tools/test.py "${CONFIG}" "${CHECKPOINT}" \
            --work-dir "${OUT_DIR}" \
            --format-only \
            --eval-options "submission_dir=${OUT_DIR}/submission" \
            --cfg-options "${COMMON_CFG[@]}"
        ;;
    *)
        echo "Usage: $0 [val|submit]" >&2
        exit 2
        ;;
esac
