ACDS
====

Automatic Cells Detection and Segmentation.

Instructions
============

The package contains the following files and folders:
- `./batch_watershed_single.m`: The batch program to detect and segment single cell automatically.
- `./batch_watershed_multiple.m`: The batch program to detect and segment multiple cells automatically.
- `./saliency_cvpr09.m`: Detects salient objects proposed by IG method [1].
- `./saliency_cvpr09_S.m`: Detects salient objects by Saturation.
- `./rgb2hsi.m`: Converts an RGB image to HSI.
- `./expectation_variance.m`: Computes the expectation and variance of a gray-level image.
- `./remove_corner_noise.m`: Removes the possible exist corner noise caused by illumination.
- `./extract_single_cell_region.m`: Extracts the biggest region for single cell.
- `./size_objects.m`: Computes the sizes of all objects.
- `./size_otsu.m`: Uses OTSU's thresholding method to classify the sizes of the objects.
- `./modify_binary_image.m`: Removes the possible exist small noise according to the size.
- `./watershed_single.m`: Marker-controlled watershed algorithm for single cell segmentation.
- `./watershed_multiple.m`: Marker-controlled watershed algorithm for multiple cells segmentation.
- `./experiments`: This folder contains the original images put in `single` and `multiple` folders, the gradient images stored in `gradients` folder, and the experimental results stored in `results` folder.

Usage
=====

#### Single Cell Detection and Segmentation

1. Put the microscopic images with single cell in `./experiments/single/` folder;
2. Run `./batch_watershed_single.m` to detect and segment the cell into `./experiments/results/single/` folder.

#### Multiple Cells Detection and Segmentation

1. Put the microscopic images with multiple cells in `./experiments/multiple/` folder;
2. Run `./batch_watershed_multiple.m` to detect and segment the cells into `./experiments/results/multiple/` folder.

References
==========

[1] Radhakrishna Achanta, Sheila Hemami, Francisco Estrada and Sabine Susstrunk, "Frequency-tuned Salient Region Detection," in IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 2009.

Contact
=======

If you have any question, please feel free to contact Haiyong Zheng (zhenghaiyong@gmail.com).
