# CEGA HRSC Experiment

This document describes the CEGA HRSC2016 test and training experiments.

## 1. Environment

Use the PETDet environment described in the PETDet README. The released
checkpoint was produced with:

```text
python == 3.10
torch == 1.13.1
cuda == 11.7
mmcv == 1.7.1
mmdet == 2.28.2
mmrotate == 0.3.2
```

Expected HRSC2016 directory layout:

```text
HRSC_ROOT/
  ImageSets/trainval.txt
  ImageSets/test.txt
  FullDataSet/Annotations/
  FullDataSet/AllImages/
```

## 2. Test Experiment

The HRSC2016 test experiment loads:

```text
work_dirs/CEGA_HRSC.pth
```

The test config in this repository is:

```text
experiments/ablation/CEGA_HRSC_config.py
```

Run from the PETDet root:

```bash
export HRSC_ROOT=/path/to/hrsc
export CHECKPOINT="$PWD/work_dirs/CEGA_HRSC.pth"
bash tools/CEGA_HRSC_test.sh
```

The output is written to:

```text
work_dirs/CEGA_HRSC_test/
```

The checkpoint metadata records:

| Item | Value |
|---|---|
| Model | `ParallelBranchPETDet` |
| Fusion | `CEGAParallelBranchFusion` |
| RPN | `ACLRPNHead` |
| RoI head | `StripHead` |
| Classes | `ship` |
| Angle version | `le90` |

## 3. Training Experiment

The training experiment uses the original PETDet config file:

```text
PETDet/experiments/ablation/serial_rot_scale_aclrpn_striphead_hrsc.py
```

Main training settings:

| Setting | Value |
|---|---|
| Backbone branches | `ReResNet-50` and `ScaleReResNet-18` |
| Fusion | `CEGAParallelBranchFusion` |
| RPN | `ACLRPNHead` |
| Head | `StripHead` |
| Optimizer | `AdamW` |
| Learning rate | `0.0005` |
| Epochs | `72` |
| Seed | `3407` |

Run from the PETDet root:

```bash
export HRSC_ROOT=/path/to/hrsc
python tools/train.py experiments/ablation/serial_rot_scale_aclrpn_striphead_hrsc.py \
  --seed 3407 \
  --cfg-options \
    data.train.ann_file="$HRSC_ROOT/ImageSets/trainval.txt" \
    data.train.ann_subdir="$HRSC_ROOT/FullDataSet/Annotations/" \
    data.train.img_subdir="$HRSC_ROOT/FullDataSet/AllImages/" \
    data.train.img_prefix="$HRSC_ROOT/FullDataSet/AllImages/" \
    data.val.ann_file="$HRSC_ROOT/ImageSets/test.txt" \
    data.val.ann_subdir="$HRSC_ROOT/FullDataSet/Annotations/" \
    data.val.img_subdir="$HRSC_ROOT/FullDataSet/AllImages/" \
    data.val.img_prefix="$HRSC_ROOT/FullDataSet/AllImages/" \
    data.test.ann_file="$HRSC_ROOT/ImageSets/test.txt" \
    data.test.ann_subdir="$HRSC_ROOT/FullDataSet/Annotations/" \
    data.test.img_subdir="$HRSC_ROOT/FullDataSet/AllImages/" \
    data.test.img_prefix="$HRSC_ROOT/FullDataSet/AllImages/"
```

The PETDet config writes training output to:

```text
work_dirs/cega_parallel_aclrpn_striphead_hrsc/
```

Do not upload HRSC2016 images or annotations to this repository.
