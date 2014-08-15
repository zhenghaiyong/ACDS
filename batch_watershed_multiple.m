%---------------------------------------------------------
% Copyright (c) 2014 Haiyong Zheng [OUC]
% Contact: zhenghaiyong@gmail.com
%---------------------------------------------------------
clc;
clear all;
%% Settings
inputdir='./DATA/MicroscopicImages/multiple/';
outputdir='./RESULTS/multiple/';
exts={'.tif','.bmp','.jpg','.png','.gif','.jpeg'};
timefile='./RESULTS/multiple.time';
%% END Settings
if exist(timefile,'file')
    delete(timefile);
end
fid=fopen(timefile,'a+');
tstart=tic;%Total time start
for i=1:length(exts)
    ext=exts{i};
    extwild=strcat('*',ext);
    inputdirformat=[inputdir extwild];
    files= dir(inputdirformat);
    for j=1:length(files)
        timg=tic;%t start
        t1img=tic;%t1 start
        imgname=files(j).name; 
        f=imread(strcat(inputdir,imgname));
        [row,col,dim] = size(f);
        if dim==1
            continue
        else
        img_color=imresize(f,1);
        img_gray=rgb2gray(img_color);
        %% Salient Objects Detection
        gf_img_color = imfilter(img_color, fspecial('gaussian', 3, 3), 'symmetric', 'conv');%Gaussian low-pass filter   
        sm_IG=saliency_cvpr09(gf_img_color,imgname,ext,outputdir);%salient objects by IG method
        sm_S=saliency_cvpr09_S(gf_img_color,imgname,ext,outputdir);%salient objects by saturation
        saliencymap=(sm_IG+sm_S);%combined salient objects
        img_sm_name=strrep(imgname,ext,'-saliencymap-3.tif');
        imwrite(saliencymap,strcat(outputdir,img_sm_name),'tif','Resolution',300);
        %% END Salient Objects Detection
        t1imgtime=toc(t1img);%t1 end
        fprintf(fid,'%10s\tSalient Objects Detection: %9.5f\t',imgname,t1imgtime);
        %% Markers Selection
        % Binarization
        thresh=graythresh(saliencymap);
        binary_saliencymap=im2bw(saliencymap,thresh);
        img_binary_saliencymap_name=strrep(imgname,ext,'-saliencymap-4-binary.tif');
        imwrite(binary_saliencymap,strcat(outputdir,img_binary_saliencymap_name),'tif','Resolution',300);
        % Removing corner noise
        binary_image=remove_corner_noise(binary_saliencymap,imgname,ext,outputdir);
        % Removing small noise    
        [sizes,max_size,num]=size_objects(binary_image);
        th=size_otsu(sizes,max_size);
        cell_region=modify_binary_image(binary_image,th,imgname,ext,outputdir);
        %% END Markers Selection
        %% Watershed from markers
        watershed_multiple(img_color,img_gray,cell_region,imgname,ext,row,col,outputdir); 
        %% END Watershed from markers
        timgtime=toc(timg);%t2 end
        fprintf(fid,'%9.5f :Automatic Detection and Segmentation\n',timgtime);
        end
    end
end
ttime=toc(tstart);%Total time end
fprintf(fid,'\n\t\tTotal running time: %g',ttime);
fclose(fid);
