clc;
clear all;
inputdir='../DATA/MicroscopicImages/single/';
outputdir='../RESULTS/2ITS/single/';
extgroup={'.tif','.bmp','.jpg','.png','.gif','.jpeg'};
timefile='../RESULTS/2ITS-single.time';
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
        its_entrance(img_color,imgname,ext,outputdir)    
        end
        timgtime=toc(timg);%t end
        fprintf(fid,'%10s\tIterative threshold selection: %9.5f\n',imgname,timgtime);
    end
end
ttime=toc(tstart);%Total time end
fprintf(fid,'\n\tTotal running time: %g\t%s',ttime,datestr(now));
fclose(fid);