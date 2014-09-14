function [binary_holes,num]=remove_corner_noise(binary_saliencymap,imgname,ext,outputdir)
%Remove the possible exist corner noise.
[row,col]=size(binary_saliencymap);
[L,num]=bwlabel(binary_saliencymap,4);
a=L(1,1);L(find(L==a))=0;
b=L(1,col);L(find(L==b))=0;
c=L(row,1);L(find(L==c))=0;
d=L(row,col);L(find(L==d))=0;
L(find(L~=0))=1;
remove_fake_markers=logical(L);
remove_fake_markers_name=strrep(imgname,ext,'-saliencymap-5-binary-removeCornerNoise.tif');
imwrite(remove_fake_markers,strcat(outputdir,remove_fake_markers_name),'tif','Resolution',300);
% closing and hole filling
se=strel('disk',3);
binary_close=imclose(remove_fake_markers,se);
binary_holes=imfill(binary_close,'holes');