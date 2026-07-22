# Reproduce the "消融实验/总体" run whose log reports AP50=0.908 at epoch 63.
# The base config matches the logged architecture:
# OrientedRCNN + ReTransformerResNet + ReFPN + StripHead + HRSC rotate aug.

_base_ = [
    '../../configs/oriented_rcnn/transformer_strip_oriented_rcnn_re50_refpn_3x_hrsc_le90.py'
]

work_dir = 'work_dirs/retrain_hrsc908_from_log'
auto_resume = False

