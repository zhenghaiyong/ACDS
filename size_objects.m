function [sizes,max_size,num]=size_objects(binary_image)
%Find and count all the objects and calculate their sizes.
[L,num]=bwlabel(binary_image,4); 
max_size=0;
sizes=[];
for i=1:num
    f=find(L==i);
    sizes=[sizes,length(f)];
    if max_size<length(f)
        max_size=length(f);
    end
end
sizes=sizes';