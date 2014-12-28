function EachMethodData=EachMethodSimilarity(ImageQuantity,GroundTruthFilePath,IdsGroundTruthImage,PathMethodImage,IdsMethodImage)
%~~~~~计算每种方法的相似度~~~~~
EachMethodData=zeros(ImageQuantity,1);
for ImageNum=1:ImageQuantity 
    EachMethodData(ImageNum,1)=EachImageSimilarity( GroundTruthFilePath,IdsGroundTruthImage,PathMethodImage,IdsMethodImage,ImageNum );
end
