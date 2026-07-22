# Reproduce `CEGA_hrsc.pth`

`work_dirs/CEGA_hrsc.pth` is an **HRSC2016 ship detector**, not a DOTA model.
The checkpoint metadata records:

- `OrientedRCNN`
- `ReTransformerResNet` with Transformer stages 3 and 4
- `ReFPN`
- `StripHead`
- one class: `ship`
- AdamW, learning rate `0.0005`
- seed `3407`
- 72 training epochs; this checkpoint was renamed from `epoch_69.pth`

The exact reference config is:

```text
experiments/ablation/retrain_hrsc908_from_log.py
```

## Environment

Use the PETDet environment described in the repository README. The recorded
checkpoint was produced with Python 3.10, PyTorch 1.13.1, CUDA 11.7, MMCV 1.7.1,
MMDetection 2.28.2, and MMRotate 0.3.2.

The HRSC directory must contain:

```text
HRSC_ROOT/
  ImageSets/trainval.txt
  ImageSets/test.txt
  FullDataSet/Annotations/
  FullDataSet/AllImages/
```

The original training config uses `/home/shared_dataset/hrsc`; the provided
script overrides this path so it can run on another machine.

## Evaluate The Checkpoint

From the PETDet root:

```bash
export HRSC_ROOT=/path/to/hrsc
export CHECKPOINT="$PWD/work_dirs/CEGA_hrsc.pth"
bash tools/reproduce_epoch69_hrsc.sh test
```

The script writes predictions and evaluation output under:

```text
work_dirs/reproduce_epoch69_hrsc/
```

## Re-train From Scratch

This reproduces the 72-epoch training recipe. It does not start from
`CEGA_hrsc.pth`.

```bash
export HRSC_ROOT=/path/to/hrsc
export OUT_DIR="$PWD/work_dirs/retrain_epoch69_hrsc"
bash tools/reproduce_epoch69_hrsc.sh train
```

The resulting checkpoint will not be bit-identical because CUDA and dependency
versions can change numerical behavior, but the architecture and training
recipe are fixed by the reference config.

## GitHub Storage

`CEGA_hrsc.pth` is about 658 MB, so it cannot be committed through ordinary
GitHub Git storage. Use Git LFS or attach it to a GitHub Release:

```bash
git lfs install
git lfs track "*.pth"
git add .gitattributes work_dirs/CEGA_hrsc.pth \
        experiments/ablation/retrain_hrsc908_from_log.py \
        tools/reproduce_epoch69_hrsc.sh docs/reproduce_epoch69_hrsc.md
git commit -m "Add HRSC epoch 69 reproduction recipe"
git push origin main
```

Do not upload the HRSC images or annotations to the repository. Users should
download the dataset separately and set `HRSC_ROOT` locally.
