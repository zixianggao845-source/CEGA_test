# CEGA_test

This repository publishes the HRSC2016 CEGA checkpoint and the minimum files
needed to evaluate it in PETDet.

## Files

- `work_dirs/CEGA_hrsc.pth`: HRSC2016 checkpoint, stored with Git LFS.
- `docs/reproduce_CEGA_hrsc.md`: environment, dataset layout, and evaluation
  steps.
- `tools/reproduce_CEGA_hrsc.sh`: helper script for evaluation.
- `experiments/ablation/cega_hrsc_config.py`: reference experiment config.

## Usage

Clone this repository with Git LFS enabled:

```bash
git lfs install
git clone https://github.com/zixianggao845-source/CEGA_test.git
```

Use these files inside a PETDet checkout. The evaluation script expects to be
run from a PETDet-style repository that contains `tools/test.py`, `mmrotate/`,
and the base configs referenced by the HRSC config.

For details, see:

```text
docs/reproduce_CEGA_hrsc.md
```

Checkpoint SHA256:

```text
0007153d48024f15397f5d8836db62a06b31bdefaa23eaa3c70fee0d7eef4309
```
