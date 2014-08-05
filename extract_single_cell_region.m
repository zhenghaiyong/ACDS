function cell_region=extract_single_cell_region(binary_image)
%Extract the biggest single cell region.
[L,num]=bwlabel(binary_image,4); 
area_vector=[];
for i=1:num
    f=find(L==i);
    area_vector=[area_vector,length(f)];
end
max_area=max(area_vector);
area=max_area-1;
cell_region=bwareaopen(L,area);