function [strMethod,idsMethod]=ImagePathMethods(MethodsNum)%存放8中方法图像的路径
FilePath={'' './method/1Canny/' './method/2ITS/' './method/3Otsu/' './method/4MET/' './method/5Kmeans/' './method/6SalientObjectsSegmentation/' './method/7RemoveCornerNoise/' './method/8WatershedFromMarkers/'};
%FilePath={'' './1Canny/' './2ITS/' './3Otsu/' './4MET/' './5Kmeans/' './6SalientObjectsSegmentation/' './7RemoveCornerNoise/' './8WatershedFromMarkers/'};
strMethod = FilePath{MethodsNum};      
SuffixMethod = '*.tif';  
PathMethod = strcat(strMethod,SuffixMethod);
idsMethod = dir(PathMethod);