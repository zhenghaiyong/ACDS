function [u,sigma]=expectation_variance(img_gray)
%Compute the expectation and variance of a gray-level image.
% input: gray-level image
% output: expectation and variance
count=imhist(img_gray);
[row,col]=size(img_gray); 
N=row*col; 
count=count/N; 
u=0;
for i=1:256 
	st=i-1;
	u=u+st*count(i);
end 
sigma=0;
for j=1:256 
	st=j-1;
	sigma=((st-u)*(st-u)/256)+sigma;
end 
sigma=sqrt(sigma);