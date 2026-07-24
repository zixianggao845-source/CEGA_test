# CEGA HRSC checkpoint config.
# The base config matches the checkpoint architecture:
# OrientedRCNN + ReTransformerResNet + ReFPN + StripHead + HRSC rotate aug.

_base_ = [
    '../../configs/oriented_rcnn/CEGA_HRSC_base_config.py'
]

work_dir = 'work_dirs/CEGA_HRSC_test'
auto_resume = False
