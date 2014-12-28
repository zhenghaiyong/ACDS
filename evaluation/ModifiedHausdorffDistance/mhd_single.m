clc;
clear all;
%% single
%%~~~~~~路径~~~~~~
MethodsFilePath={'' '../../RESULTS/Segmentation/single/1Canny/' '../../RESULTS/Segmentation/single/2ITS/' '../../RESULTS/Segmentation/single/3Otsu/' '../../RESULTS/Segmentation/single/4MET/' '../../RESULTS/Segmentation/single/5Kmeans/' '../../RESULTS/Segmentation/single/6SalientObjectsSegmentation/' '../../RESULTS/Segmentation/single/7RemoveCornerNoise/' '../../RESULTS/Segmentation/single/8WatershedFromMarkers/'};
%MethodsFilePath={'' './1Canny/' './2ITS/' './3Otsu/' './4MET/' './5Kmeans/' './6SalientObjectsSegmentation/' './7RemoveCornerNoise/' './8WatershedFromMarkers/'};   
MethodsFile = '../../RESULTS/Segmentation/single/';
SuffixMethodImage = '*.tif';%每种方法中图像的后缀  
GroundTruthFilePath = '../../DATA/GroundTruth/single/';      
SuffixGroundTruthImage = '*.png';%GroundTruth图的后缀
%%
%%~~~~~~计算一共有几种方法和每种方法下图片的数量~~~~~~
PathGroundTruthSuffix = strcat(GroundTruthFilePath,SuffixGroundTruthImage);
IdsGroundTruthImage = dir(PathGroundTruthSuffix);
ImageQuantity=length(IdsGroundTruthImage);%图像的张数;
   
IdsMethod = dir(MethodsFile);
MethodsQuantity=length(IdsMethod)-1;%方法数量+1
%%
%%~~~~~~在.txt中写入表头~~~~~~
fid=fopen( 'single.mhd' , 'w' );
	fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s \n','','1Canny','2ITS','3Otsu','4MET','5Kmeans','Saliency','Corner','Small');
fclose(fid);
%%
%%~~~~~~~计算出的相似度数据~~~~~~~~~~~~~~~~~~
SimilarityData=zeros(ImageQuantity,MethodsQuantity);
for MethodsNum=1:MethodsQuantity
    if MethodsNum==1%~~~数组的第一列为图像的编号
       for ImageNum=1:ImageQuantity
           SimilarityData(ImageNum,MethodsNum)=ImageNum;
       end
    else
        PathMethodImage = MethodsFilePath{MethodsNum};
        PathMethodSuffix = strcat(PathMethodImage,SuffixMethodImage);
        IdsMethodImage = dir(PathMethodSuffix);
        EachMethodData=EachMethodSimilarity(ImageQuantity,GroundTruthFilePath,IdsGroundTruthImage,PathMethodImage,IdsMethodImage);%计算每种方法的相似度
        for ImageNum=1:ImageQuantity
            SimilarityData(ImageNum,MethodsNum)=EachMethodData(ImageNum,1); %将所有方法的相似度存放在同一个数组中
        end
    end
end
%%
%%~~~~~~~将数据存放在.txt中~~~~~~~
fid=fopen( 'single.mhd' , 'a+' );
for ImageNum=1:ImageQuantity
    for MethodsNum=1:MethodsQuantity
        fprintf(fid,'%f\t ',SimilarityData(ImageNum,MethodsNum));
    end
    fprintf(fid,'\n');
end
fclose(fid);