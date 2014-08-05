clear all
img=imread('./experiments/single/DictyochaFibula.jpg');
originalname='./experiments/gradients/DictyochaFibula';
% img=imread('./experiments/multiple/ChattonellaMarina1.tif');
% originalname='./experiments/gradients/ChattonellaMarina1';
f=rgb2gray(img);
se=strel('disk',3);
f1=imdilate(f,se);
f2=imerode(f,se);
img_gradient=imsubtract(f1,f2);
img_gradient_name=strcat(originalname,'-gradient.tif');
imwrite(img_gradient,img_gradient_name,'tif','Resolution',300);