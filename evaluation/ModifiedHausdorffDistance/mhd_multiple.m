clc;
clear all;
%%
%%路径
InputMethods='../../RESULTS/Segmentation/multiple/';
InputGroundTruth='../../DATA/GroundTruth/multiple/';
SuffixGroundTruthImage = '*.png';
DataTxt='multiple.mhd';
IdsInputMethods=dir(InputMethods);
MethodsQuantity=length(IdsInputMethods);
Dimension=1;
HiddenFilesNumber=0;
for i=1:MethodsQuantity
    if IdsInputMethods(i).name(1)=='.'
        continue;
    end
    Dimension=Dimension+1;
end
%%
%%计算一共有几种方法和每种方法下图片的数量
PathGroundTruthSuffix = strcat(InputGroundTruth,SuffixGroundTruthImage);
IdsGroundTruthImage = dir(PathGroundTruthSuffix);
ImageQuantity=length(IdsGroundTruthImage);%图像的张数; 
%%
%%计算出的相似度数据
SimilarityData=zeros(ImageQuantity,Dimension);
ImagesName=cell(ImageQuantity,1);
Num=1;
for m=1:MethodsQuantity
    j=0;
    MethodsFilePath=strcat(InputMethods,IdsInputMethods(m).name,'/');%存放各种方法的路径
    ImageName=dir(MethodsFilePath);
    FileQuantity=length(ImageName);
    if IdsInputMethods(m).name(1)=='.'
        HiddenFilesNumber=HiddenFilesNumber+1;
        continue;
    end
    for i=1:FileQuantity
        if ImageName(i).name(1)=='.'
            continue;
        end
        if strcmp(ImageName(i).name((end-2):end), 'jpg' )||...
                strcmp(ImageName(i).name((end-2):end), 'png' )||...
                strcmp(ImageName(i).name((end-2):end), 'tif' )||...
                strcmp(ImageName(i).name((end-2):end), 'bmp' )
            j=j+1;
            ImagesName{j}=ImageName(i);
        end
    end
    Num=Num+1;
EachMethodData=EachMethodSimilarity(ImageQuantity,InputGroundTruth,IdsGroundTruthImage,MethodsFilePath,ImagesName);%计算每种方法的相似度
    for n=1:ImageQuantity
        SimilarityData(n,Num)=EachMethodData(n,1); %将所有方法的相似度存放在同一个数组中
    end
end
for n=1:ImageQuantity%数组第一列存放图片的标号
    SimilarityData(n,1)=n;
end
%%
FileExist=exist(DataTxt,'file');%判断是否有data.txt,如果有就删掉
if FileExist==2;
    delete(DataTxt);
end
fid=fopen( DataTxt , 'a+' );
fprintf(fid,'%s\t','');
for m=(HiddenFilesNumber+1):MethodsQuantity
    fprintf(fid,'%s\t',IdsInputMethods(m).name);  
end
fprintf(fid,'\n');
for n=1:ImageQuantity
    for m=1:Dimension
        fprintf(fid,'%f\t ',SimilarityData(n,m));
    end
    fprintf(fid,'\n');
end
fclose(fid);