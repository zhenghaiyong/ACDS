clc;
clear all;
inputdir='../DATA/GroundTruth/multiple/';
extgroup={'.tif','.bmp','.jpg','.png','.gif','.jpeg'};
cellsfile='../RESULTS/GroundTruth-multiple.cells';
if exist(cellsfile,'file')
    delete(cellsfile)
end
cellsfid=fopen(cellsfile,'a+');
fprintf(cellsfid,'GT');
for i = 1:length(extgroup)
    ext=extgroup(i);
    ext=ext{1};
    extwild=strcat('*',ext);
    inputdirformat= [inputdir extwild];
    files= dir(inputdirformat);
    for j=1:length(files)
        imgname = files(j).name; 
        f = imread(strcat(inputdir,imgname));
        [row,col,dim] = size(f);
        if dim~=1
            continue
        else
        cc=bwconncomp(f);
        numCells=cc.NumObjects;
        fprintf(cellsfid,'\n%d',numCells);
        end
    end
end
fclose(cellsfid);