# Reproduce `CEGA_hrsc.pth`

`work_dirs/CEGA_hrsc.pth` is an HRSC2016 ship detector checkpoint.

Checkpoint metadata records:

- `OrientedRCNN`
- `ReTransformerResNet` with Transformer stages 3 and 4
- `ReFPN`
- `StripHead`
- one class: `ship`

Reference config:

```text
experiments/ablation/cega_hrsc_config.py
```

## Environment

Use the PETDet environment described in the PETDet repository README. The
checkpoint was produced with Python 3.10, PyTorch 1.13.1, CUDA 11.7, MMCV
1.7.1, MMDetection 2.28.2, and MMRotate 0.3.2.

The HRSC directory must contain:

```text
HRSC_ROOT/
  ImageSets/test.txt
  FullDataSet/Annotations/
  FullDataSet/AllImages/
```

## Evaluate The Checkpoint

From the PETDet root:

```bash
export HRSC_ROOT=/path/to/hrsc
export CHECKPOINT="$PWD/work_dirs/CEGA_hrsc.pth"
bash tools/reproduce_CEGA_hrsc.sh
```

The script writes predictions and evaluation output under:

```text
work_dirs/reproduce_CEGA_hrsc/
```

Do not upload the HRSC images or annotations to the repository. Users should
download the dataset separately and set `HRSC_ROOT` locally.
