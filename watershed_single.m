function watershed_single(img_color,img_gray,img_binary,originalname,ext,row,col,outputdir)
% img_color: RGB image
% f: graylevel image
% binary_image: binary image

%% gradient image
se=strel('disk',3);
f1=imdilate(img_gray,se);
f2=imerode(img_gray,se);
img_gradient=imsubtract(f1,f2);
% img_gradient_name=strrep(originalname,'-gradient.tif');
% imwrite(img_gradient,strcat(outputdir,img_gradient_name),'tif','Resolution',1000);
%% END gradient image

img_dilate=bwmorph(img_binary,'dilate',2);
img_dilate=~img_dilate;
img_erode=bwmorph(img_binary,'erode',2);

%% Markers
%TIME%markers=imimposemin(f,img_dilate|img_erode);
%TIME%img_markers_name=strrep(originalname,ext,'-watershed-0-markers.tif');
%TIME%imwrite(markers,strcat(outputdir,img_markers_name),'tif','Resolution',300);
%% END Markers

%% Watershed from markers
g2=imimposemin(img_gradient,img_dilate|img_erode);
%TIME%img_gradient_watershed_name=strrep(originalname,ext,'-watershed-1-gradient.tif');
%TIME%imwrite(g2,strcat(outputdir,img_gradient_watershed_name),'tif','Resolution',300);
L1=watershed(g2);

%overlap ridge lines on graylevel images
% f(L1~=2)=0;
% img_ridgelines_gray_name=strrep(originalname,ext,'-watershed-ridgelinegray.tif');
% imwrite(f,strcat(outputdir,img_ridgelines_gray_name),'tif','Resolution',300);

%ridge lines
L=L1==0;
% L=~L;
%TIME%img_result_ridgelines_name=strrep(originalname,ext,'-watershed-2-ridgelines.tif');
%TIME%imwrite(L,strcat(outputdir,img_result_ridgelines_name),'tif','Resolution',300);

%binary segmentation result
img_result_binary=ones(row,col);
img_result_binary(L1==0)=0;
img_result_binary(L1==1)=0;
img_object_binary_name=strrep(originalname,ext,'-watershed-3-binary.tif');
imwrite(img_result_binary,strcat(outputdir,img_object_binary_name),'tif','Resolution',300);

%graylevel segmentation result
%TIME%f1=img_gray;
%TIME%f1(img_result_binary==0)=0;
%TIME%img_object_gray_name=strrep(originalname,ext,'-watershed-4-gray.tif');
%TIME%imwrite(f1,strcat(outputdir,img_object_gray_name),'tif','Resolution',300);

%color segmentation result
r = img_color(:,:,1); r(img_result_binary==0)=0;
g = img_color(:,:,2); g(img_result_binary==0)=0;
b = img_color(:,:,3); b(img_result_binary==0)=0;
% b = img_color(:,:,3); b(L1~=2)=0;
color=cat(3,r,g,b);
img_object_color_name=strrep(originalname,ext,'-watershed-5-color.tif');
imwrite(color,strcat(outputdir,img_object_color_name),'tif','Resolution',300);
