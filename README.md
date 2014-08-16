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
- `./DATA`: This folder contains the benchmark DATASET for automatic cells detection and segmentation with `MicroscopicImages` and `GroundTruth` containing `single` and `multiple` resepectively.
- `./RESULTS`: This folder contains the RESULTS for automatic cells detection and segmentation.
- `./tools`: This folder contains some useful scripts.

Usage
=====

#### Single Cell Detection and Segmentation

1. Put the microscopic images with single cell in `./DATA/MicroscopicImages/single/` folder;
2. Run `./batch_watershed_single.m` to detect and segment the cell into `./RESULTS/single/` folder with the running time records in `./RESULTS/single.time`.

#### Multiple Cells Detection and Segmentation

1. Put the microscopic images with multiple cells in `./DATA/MicroscopicImages/multiple/` folder;
2. Run `./batch_watershed_multiple.m` to detect and segment the cells into `./RESULTS/multiple/` folder with the running time records in `./RESULTS/multiple.time`.

References
==========

[1] Radhakrishna Achanta, Sheila Hemami, Francisco Estrada and Sabine Susstrunk, "Frequency-tuned Salient Region Detection," in IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 2009.

Copyright
==========

This software is free for use in research projects. If you publish results obtained using this software, please use this citation.

Contact
=======

If you have any question, please feel free to contact Haiyong Zheng (zhenghaiyong@gmail.com).
