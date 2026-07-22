# CEGA HRSC checkpoint config.
# The base config matches the checkpoint architecture:
# OrientedRCNN + ReTransformerResNet + ReFPN + StripHead + HRSC rotate aug.

_base_ = [
    '../../configs/oriented_rcnn/transformer_strip_oriented_rcnn_re50_refpn_3x_hrsc_le90.py'
]

work_dir = 'work_dirs/reproduce_CEGA_hrsc'
auto_resume = False
