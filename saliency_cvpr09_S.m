%---------------------------------------------------------
% Copyright (c) 2009 Radhakrishna Achanta [EPFL]
% Contact: firstname.lastname@epfl.ch
%---------------------------------------------------------
% Citation:
% @InProceedings{LCAV-CONF-2009-012,
%    author      = {Achanta, Radhakrishna and Hemami, Sheila and Estrada,
%                  Francisco and S�sstrunk, Sabine},
%    booktitle   = {{IEEE} {I}nternational {C}onference on {C}omputer
%                  {V}ision and {P}attern {R}ecognition},
%    year        = 2009
% }
%---------------------------------------------------------
% Please note that the saliency maps generated using this
% code may be slightly different from those of the paper.
% This seems to be because the RGB to Lab conversion is
% different from the one used for the results in the C++ code.
% The C++ code is available on the same page as this matlab
% code (http://ivrg.epfl.ch/supplementary_material/RK_CVPR09/index.html)
% One should preferably use the C++ as reference and use
% this matlab implementation mostly as proof of concept
% demo code.
%---------------------------------------------------------
%
function sm=saliency_cvpr09_S(img_color,imgname,ext,outputdir)
%---------------------------------------------------------
% Perform RGB to HSI color space conversion
% (Digital Image Processing Using MATLAB written by Gonzalez)
%---------------------------------------------------------
hsi=rgb2hsi(img_color);
%---------------------------------------------------------
% Compute S average values (note that in CVPR09 this
% average is found from the unblurred original image, but
% the results are quite similar)
%---------------------------------------------------------
% h = double(hsi(:,:,1)); hm = mean(mean(h));
s = double(hsi(:,:,2)); sm = mean(mean(s));
% i = double(hsi(:,:,3)); im = mean(mean(i));
%---------------------------------------------------------
% Finally compute the saliency map and display it.
%---------------------------------------------------------
sm_distance = (s-sm).^2 ;
sm=im2uint8(mat2gray(sm_distance));
%TIME%img_sm_name=strrep(imgname,ext,'-saliencymap-2-S.tif');
%TIME%imwrite(sm,strcat(outputdir,img_sm_name),'tif','Resolution',300);
%---------------------------------------------------------
