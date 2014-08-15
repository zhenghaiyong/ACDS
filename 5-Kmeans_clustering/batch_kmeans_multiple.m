clc;
clear all;
inputdir='../DATA/MicroscopicImages/multiple/';
outputdir='../RESULTS/5Kmeans/multiple/';
extgroup={'.tif','.bmp','.jpg','.png','.gif','.jpeg'};
timefile='../RESULTS/5Kmeans-multiple.time';
if exist(timefile,'file')
    delete(timefile);
end
fid=fopen(timefile,'a+');
tstart=tic;%Total time start
for i = 1:length(extgroup)
    ext=extgroup(i);
    ext=ext{1};
    extwild=strcat('*',ext);
    inputdirformat= [inputdir extwild];
    files= dir(inputdirformat);
    for j=1:length(files)
        timg=tic;%t start
        imgname = files(j).name; 
        f = imread(strcat(inputdir,imgname));
        [row,col,dim] = size(f);
        if dim==1
            continue
        else
        img_color=imresize(f,1);
        kmeans_entrance(img_color,imgname,ext,outputdir)
        end
        timgtime=toc(timg);%t end
        fprintf(fid,'%10s\tK-means clustering: %9.5f\n',imgname,timgtime);
     end
end
ttime=toc(tstart);%Total time end
fprintf(fid,'\n\t\tTotal running time: %g',ttime);
fclose(fid);