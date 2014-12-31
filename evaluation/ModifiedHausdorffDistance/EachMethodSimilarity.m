function EachMethodData=EachMethodSimilarity(ImageQuantity,GroundTruthFilePath,IdsGroundTruthImage,MethodsFilePath,ImagesName)
%%计算每种方法的相似度
EachMethodData=zeros(ImageQuantity,1);
for ImageNumber=1:ImageQuantity 
    EachMethodData(ImageNumber,1)=EachImageSimilarity( GroundTruthFilePath,IdsGroundTruthImage,MethodsFilePath,ImagesName,ImageNumber );
end