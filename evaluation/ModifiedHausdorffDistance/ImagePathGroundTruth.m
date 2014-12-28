function [strGroundTruth,idsGroundTruth]=ImagePathGroundTruth()%存放GroundTruth图的路径
strGroundTruth = './groundtruth/';      
SuffixGroundTruth = '*.png';  
PathGroundTruth = strcat(strGroundTruth,SuffixGroundTruth);
idsGroundTruth = dir(PathGroundTruth);

