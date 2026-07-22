#!/usr/bin/env bash
set -euo pipefail

# Reproduce or evaluate work_dirs/CEGA_hrsc.pth.
# Required environment variable: HRSC_ROOT
# Optional: CHECKPOINT, OUT_DIR, SEED

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG="${ROOT}/experiments/ablation/retrain_hrsc908_from_log.py"
HRSC_ROOT="${HRSC_ROOT:?Set HRSC_ROOT to the HRSC dataset root}"
CHECKPOINT="${CHECKPOINT:-${ROOT}/work_dirs/CEGA_hrsc.pth}"
OUT_DIR="${OUT_DIR:-${ROOT}/work_dirs/reproduce_epoch69_hrsc}"
SEED="${SEED:-3407}"
PYTHON="${PYTHON:-python}"

COMMON_CFG=(
    "data.train.ann_file=${HRSC_ROOT}/ImageSets/trainval.txt"
    "data.train.ann_subdir=${HRSC_ROOT}/FullDataSet/Annotations/"
    "data.train.img_subdir=${HRSC_ROOT}/FullDataSet/AllImages/"
    "data.train.img_prefix=${HRSC_ROOT}/FullDataSet/AllImages/"
    "data.val.ann_file=${HRSC_ROOT}/ImageSets/test.txt"
    "data.val.ann_subdir=${HRSC_ROOT}/FullDataSet/Annotations/"
    "data.val.img_subdir=${HRSC_ROOT}/FullDataSet/AllImages/"
    "data.val.img_prefix=${HRSC_ROOT}/FullDataSet/AllImages/"
    "data.test.ann_file=${HRSC_ROOT}/ImageSets/test.txt"
    "data.test.ann_subdir=${HRSC_ROOT}/FullDataSet/Annotations/"
    "data.test.img_subdir=${HRSC_ROOT}/FullDataSet/AllImages/"
    "data.test.img_prefix=${HRSC_ROOT}/FullDataSet/AllImages/"
)

cd "${ROOT}"

case "${1:-test}" in
    test)
        if [[ ! -f "${CHECKPOINT}" ]]; then
            echo "Checkpoint not found: ${CHECKPOINT}" >&2
            exit 1
        fi
        mkdir -p "${OUT_DIR}"
        "${PYTHON}" tools/test.py "${CONFIG}" "${CHECKPOINT}" \
            --work-dir "${OUT_DIR}" \
            --out "${OUT_DIR}/CEGA_hrsc_results.pkl" \
            --eval mAP \
            --cfg-options "${COMMON_CFG[@]}"
        ;;
    train)
        "${PYTHON}" tools/train.py "${CONFIG}" \
            --work-dir "${OUT_DIR}" \
            --seed "${SEED}" \
            --cfg-options "${COMMON_CFG[@]}"
        ;;
    *)
        echo "Usage: $0 [test|train]" >&2
        exit 2
        ;;
esac
