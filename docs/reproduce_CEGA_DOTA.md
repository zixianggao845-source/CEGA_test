# Reproduce `CEGA_DOTA.pth`

`work_dirs/strip_rcnn_s_fpn_1x_dota_le90/CEGA_DOTA.pth` is a DOTA v1.0
oriented object detector checkpoint.

Checkpoint metadata records:

- `StripRCNN`
- `StripNet-S`
- `FPN`
- `OrientedRPNHead`
- `StripHead`
- 15 DOTA v1.0 classes
- angle version: `le90`

Reference config:

```text
configs/strip_rcnn/cega_dota_config.py
```

## Environment

Use the PETDet environment described in the PETDet repository README. The
checkpoint was produced with Python 3.10.16, PyTorch 1.13.1, CUDA 11.7, MMCV
1.7.1, MMDetection 2.28.2, and MMRotate 0.3.2+.

The split DOTA directory must contain:

```text
DOTA_ROOT/
  trainval/
    annfiles/
    images/
  test/
    images/
```

## Evaluate The Checkpoint

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

The script writes output under:

```text
work_dirs/reproduce_CEGA_DOTA/
```

## Train CEGA DOTA

Training uses the original PETDet DOTA training config:

```text
configs/strip_rcnn/strip_rcnn_s_fpn_1x_dota_le90.py
```

From the PETDet root:

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

The original DOTA config expects the StripNet-S pretrained weight at:

```text
pretrained/stripnet_s.pth
```

The training output is written to the work directory defined by the PETDet
config unless `--work-dir` is supplied.

Do not upload DOTA images or annotations to the repository. Users should
download and split the dataset separately, then set `DOTA_ROOT` locally.
