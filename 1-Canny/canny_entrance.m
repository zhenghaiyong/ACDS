function canny_entrance(img_color,imgname,ext,outputdir)

img_gray=rgb2gray(img_color);
BW_edge = edge(img_gray,'canny',[0.04,0.10],1.5);
img_edge_name=strrep(imgname,ext,'-Canny.tif');
imwrite(BW_edge,strcat(outputdir,img_edge_name),'tif','Resolution',300);

se=strel('disk',5);
binary_dilate=imdilate(BW_edge,se);
binary_holes=imfill(binary_dilate,'holes');
[L,num]=bwlabel(binary_holes,4); 

max=0;
label=0;
for i=1:num;
f=find(L==i);
if max<length(f)
max=length(f);
label=i;
end
end
L(find(L~=label))=0;
gd=imerode(L,se);
img_binary_name=strrep(imgname,ext,'-binary-Canny.tif');
imwrite(gd,strcat(outputdir,img_binary_name),'tif','Resolution',300);
r=img_color(:,:,1);
g=img_color(:,:,2);
b=img_color(:,:,3);
r(gd==0)=0;
g(gd==0)=0;
b(gd==0)=0;
img_color=cat(3,r,g,b);
img_object_name=strrep(imgname,ext,'-object-Canny.tif');
imwrite(img_color,strcat(outputdir,img_object_name),'tif','Resolution',300);
