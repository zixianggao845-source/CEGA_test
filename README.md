# CEGA Test

This warehouse provides testing and training instructions for the project. The original PETDet configuration file description and training steps are listed below. At present, the project provides models and testing steps. The complete training experiment file is not yet included, and the training file will be added later.
## 1. Environment

Use a PETDet environment with the same core dependencies:

```text
python == 3.10
torch == 1.13.1
cuda == 11.7
mmcv == 1.7.1
mmdet == 2.28.2
mmrotate == 0.3.2
```


## 2. Test Experiments

This project uses the following two datasets.

| Dataset | Checkpoint | Test script | Config | mAP |
|---|---|---|---|---|
| HRSC2016 | `work_dirs/CEGA_HRSC.pth` | `tools/CEGA_HRSC_test.sh` | `experiments/ablation/CEGA_HRSC_config.py` | `90.80%` |
| DOTA v1.0 | `work_dirs/CEGA_DOTA/CEGA_DOTA.pth` | `tools/CEGA_DOTA_test.sh` | `configs/strip_rcnn/CEGA_DOTA_config.py` | `87.85%` |

### 2.1 HRSC2016 Test

Set `HRSC_ROOT` to the HRSC2016 dataset root, then run:

```bash
export HRSC_ROOT=/path/to/hrsc
export CHECKPOINT="$PWD/work_dirs/CEGA_HRSC.pth"
bash tools/CEGA_HRSC_test.sh
```

### 2.2 DOTA v1.0 Test

Expected split DOTA :

```text
DOTA_ROOT/
  trainval/
    annfiles/
    images/
  test/
    images/
```

Run validation mAP from the PETDet root:

```bash
export DOTA_ROOT=/path/to/split_1024_dota1_0
export CHECKPOINT="$PWD/work_dirs/CEGA_DOTA/CEGA_DOTA.pth"
bash tools/CEGA_DOTA_test.sh val
```

Generate DOTA Task1 submission files:

```bash
export DOTA_ROOT=/path/to/split_1024_dota1_0
export CHECKPOINT="$PWD/work_dirs/CEGA_DOTA/CEGA_DOTA.pth"
bash tools/CEGA_DOTA_test.sh submit
```

The output is written to:

```text
work_dirs/CEGA_DOTA_test/
```

## 3. Training Experiments

This project uses the following two datasets.

| Dataset | PETDet training config | Main setting |
|---|---|---|
| HRSC2016 | `PETDet/experiments/ablation/serial_rot_scale_aclrpn_striphead_hrsc.py` | CEGA parallel branch, ACL-RPN, StripHead, 72 epochs |
| DOTA v1.0 | `PETDet/experiments/ablation/serial_rot_scale_aclrpn_striphead_dota.py` | CEGA parallel branch, ACL-RPN, StripHead, 12 epochs |

### 3.1 HRSC2016 Training

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

### 3.2 DOTA v1.0 Training

Run from the PETDet root:

```bash
export DOTA_ROOT=/path/to/dota_group_split_3407
python tools/train.py experiments/ablation/serial_rot_scale_aclrpn_striphead_dota.py \
  --seed 332845056 \
  --cfg-options \
    data.train.ann_file="$DOTA_ROOT/train/annfiles/" \
    data.train.img_prefix="$DOTA_ROOT/train/images/" \
    data.val.ann_file="$DOTA_ROOT/val/annfiles/" \
    data.val.img_prefix="$DOTA_ROOT/val/images/" \
    data.test.ann_file="$DOTA_ROOT/val/annfiles/" \
    data.test.img_prefix="$DOTA_ROOT/val/images/"
```

## 4. Checkpoint Hashes

```text
CEGA_HRSC.pth:
0007153d48024f15397f5d8836db62a06b31bdefaa23eaa3c70fee0d7eef4309

CEGA_DOTA.pth:
d0cb1bb9cc5f0d98d45baa285067f5300131b48dd14ab9a900eb0058cea5e0b6
```

Do not upload HRSC2016 or DOTA images and annotations to this repository.
Download the datasets separately and set `HRSC_ROOT` or `DOTA_ROOT` locally.
