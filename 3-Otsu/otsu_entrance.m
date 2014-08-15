function otsu_entrance(img_color,imgname,ext,outputdir)

img_gray=rgb2gray(img_color);
level = graythresh(img_gray);
BW = ~im2bw(img_gray,level);
img_binary_name=strrep(imgname,ext,'-binary-Otsu.tif');
imwrite(BW,strcat(outputdir,img_binary_name),'tif','Resolution',300);

se=strel('disk',5);
binary_close=imclose(BW,se);
binary_holes=imfill(binary_close,'holes');
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
r=img_color(:,:,1);
g=img_color(:,:,2);
b=img_color(:,:,3);
r(L==0)=0;
g(L==0)=0;
b(L==0)=0;
img_color=cat(3,r,g,b);
img_object_name=strrep(imgname,ext,'-object-Otsu.tif');
imwrite(img_color,strcat(outputdir,img_object_name),'tif','Resolution',300);
