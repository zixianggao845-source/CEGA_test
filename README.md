# CEGA_test

This repository publishes CEGA checkpoints, evaluation steps, and training
steps for PETDet.

## Files

- `work_dirs/CEGA_hrsc.pth`: HRSC2016 checkpoint, stored with Git LFS.
- `work_dirs/strip_rcnn_s_fpn_1x_dota_le90/CEGA_DOTA.pth`: DOTA v1.0
  checkpoint, stored with Git LFS.
- `docs/reproduce_CEGA_hrsc.md`: HRSC2016 evaluation and training steps.
- `docs/reproduce_CEGA_DOTA.md`: DOTA v1.0 evaluation and training steps.
- `tools/reproduce_CEGA_hrsc.sh`: HRSC2016 evaluation script.
- `tools/reproduce_CEGA_DOTA.sh`: DOTA v1.0 evaluation script.
- `experiments/ablation/cega_hrsc_config.py`: HRSC2016 checkpoint config.
- `configs/strip_rcnn/cega_dota_config.py`: DOTA v1.0 checkpoint config.

## Usage

Clone this repository with Git LFS enabled:

```bash
git lfs install
git clone https://github.com/zixianggao845-source/CEGA_test.git
```

Use these files inside a PETDet checkout. The commands expect to run from a
PETDet-style repository that contains `tools/test.py`, `tools/train.py`,
`mmrotate/`, and the base configs referenced by the HRSC config.

## Reproduce CEGA HRSC

From the PETDet root:

```bash
export HRSC_ROOT=/path/to/hrsc
export CHECKPOINT="$PWD/work_dirs/CEGA_hrsc.pth"
bash tools/reproduce_CEGA_hrsc.sh
```

The evaluation output is written to:

```text
work_dirs/reproduce_CEGA_hrsc/
```

Train CEGA HRSC from the PETDet root:

```bash
export HRSC_ROOT=/path/to/hrsc
python tools/train.py experiments/ablation/cega_hrsc_config.py \
  --work-dir work_dirs/train_CEGA_hrsc \
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

## Reproduce CEGA DOTA

From the PETDet root, run validation mAP:

```bash
export DOTA_ROOT=/path/to/split_1024_dota1_0
export CHECKPOINT="$PWD/work_dirs/strip_rcnn_s_fpn_1x_dota_le90/CEGA_DOTA.pth"
bash tools/reproduce_CEGA_DOTA.sh val
```

Generate DOTA Task1 submission files:

```bash
export DOTA_ROOT=/path/to/split_1024_dota1_0
export CHECKPOINT="$PWD/work_dirs/strip_rcnn_s_fpn_1x_dota_le90/CEGA_DOTA.pth"
bash tools/reproduce_CEGA_DOTA.sh submit
```

The evaluation output is written to:

```text
work_dirs/reproduce_CEGA_DOTA/
```

Train CEGA DOTA from the PETDet root with the original PETDet DOTA training
config:

```bash
export DOTA_ROOT=/path/to/split_1024_dota1_0
python tools/train.py configs/strip_rcnn/strip_rcnn_s_fpn_1x_dota_le90.py \
  --seed 1110166606 \
  --cfg-options \
    data.train.ann_file="$DOTA_ROOT/trainval/annfiles/" \
    data.train.img_prefix="$DOTA_ROOT/trainval/images/" \
    data.val.ann_file="$DOTA_ROOT/trainval/annfiles/" \
    data.val.img_prefix="$DOTA_ROOT/trainval/images/" \
    data.test.ann_file="$DOTA_ROOT/test/images/" \
    data.test.img_prefix="$DOTA_ROOT/test/images/"
```

For details, see:

```text
docs/reproduce_CEGA_hrsc.md
docs/reproduce_CEGA_DOTA.md
```

Checkpoint SHA256 values:

```text
CEGA_hrsc.pth:
0007153d48024f15397f5d8836db62a06b31bdefaa23eaa3c70fee0d7eef4309

CEGA_DOTA.pth:
d0cb1bb9cc5f0d98d45baa285067f5300131b48dd14ab9a900eb0058cea5e0b6
```
