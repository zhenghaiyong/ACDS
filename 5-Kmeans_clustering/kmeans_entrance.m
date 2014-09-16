function numObjects=kmeans_entrance(img_color,imgname,ext,outputdir)

img_gray=rgb2gray(img_color);
img = imadjust(img_gray);
img=double(img);
for i=1:200
    c1(1)=50;
    c2(1)=200;  
    r=abs(img-c1(i));
    g=abs(img-c2(i));  
    r_g=r-g;
    n_r=find(r_g<=0);  
    n_g=find(r_g>0);  
    i=i+1;
    c1(i)=sum(img(n_r))/length(n_r);
    c2(i)=sum(img(n_g))/length(n_g);
    d1(i)=abs(c1(i)-c1(i-1));
    d2(i)=abs(c2(i)-c2(i-1));
    if d1(i)<=0.001&&d2(i)<=0.001
        R=c1(i);
        G=c2(i);
        k=i; 
        break;
    end
end
img=uint8(img);
img(find(img<R))=0;
img(find(img>=R))=255;
img=~img;
img_binary_name=strrep(imgname,ext,'-binary-Kmeans.tif');
imwrite(img,strcat(outputdir,img_binary_name),'tif','Resolution',300);

se=strel('disk',5);
binary_close=imclose(img,se);
binary_holes=imfill(binary_close,'holes');
[L,num]=bwlabel(binary_holes,4);
numObjects=num;

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
img_R=img_color(:,:,1);
img_G=img_color(:,:,2);
img_B=img_color(:,:,3);
img_R(L==0)=0;
img_G(L==0)=0;
img_B(L==0)=0;
img_color=cat(3,img_R,img_G,img_B);
img_object_name=strrep(imgname,ext,'-object-Kmeans.tif');
imwrite(img_color,strcat(outputdir,img_object_name),'tif','Resolution',300);