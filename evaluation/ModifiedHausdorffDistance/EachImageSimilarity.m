function EachImageData=EachImageSimilarity( GroundTruthFilePath,IdsGroundTruthImage,MethodsFilePath,ImagesName,ImageNumber )%计算每幅图像的相似度
imgdir1 = strcat( GroundTruthFilePath,IdsGroundTruthImage(ImageNumber).name ); 
imgdir2 = strcat( MethodsFilePath,ImagesName{ImageNumber}.name);  
GroundTruth=imread(imgdir1); 
EachMethod=imread(imgdir2); 
EdgeGroundTruth=edge(GroundTruth,'canny'); 
EdgeEachMethod=edge(EachMethod,'canny'); 
[xEdgeGroundTruth,yEdgeGroundTruth]=size(EdgeGroundTruth); 
[xEdgeEachMethod,yEdgeEachMethod]=size(EdgeEachMethod); 
t=0; 
    for t1=1:xEdgeGroundTruth 
        for t2=1:yEdgeGroundTruth 
            if(EdgeGroundTruth(t1,t2)==1) 
                t=t+1; 
            end 
        end 
    end 
 w=zeros(t,2); 
 p=0; 
  for t1=1:xEdgeGroundTruth 
      for t2=1:yEdgeGroundTruth        
          if EdgeGroundTruth(t1,t2)==1 
              p=p+1; 
              w(p,:)=[t1 t2]; 
          else 
              continue 
          end 
      end 
  end  
  tt=0; 
    for tt1=1:xEdgeEachMethod 
        for tt2=1:yEdgeEachMethod 
            if(EdgeEachMethod(tt1,tt2)==1) 
                tt=tt+1; 
            end 
        end 
    end 
 ww=zeros(tt,2); 
  pp=0; 
      for tt1=1:xEdgeEachMethod 
          for tt2=1:yEdgeEachMethod 
              if EdgeEachMethod(tt1,tt2)==1 
                  pp=pp+1; 
                  ww(pp,:)=[tt1 tt2]; 
              else 
                  continue 
              end 
          end 
      end 
fhd = 0; 
    for i=1:t 
    min_a=sqrt((w(i,1)-ww(1,1)).^2+(w(i,2)-ww(1,2)).^2); 
        for j=2:tt 
            if sqrt((w(i,1)-ww(j,1)).^2+(w(i,2)-ww(j,2)).^2)<min_a 
            min_a=sqrt((w(i,1)-ww(j,1)).^2+(w(i,2)-ww(j,2)).^2); 
            end 
        end 
    fhd = fhd + min_a; 
    end 
fhd = fhd/t;
rhd = 0;
    for l=1:tt  
           min_b=sqrt((ww(l,1)-w(1,1)).^2+(ww(l,2)-w(1,2)).^2); 
        for k=2:t 
            if sqrt((ww(l,1)-w(k,1)).^2+(ww(l,2)-w(k,2)).^2)<min_b   
            min_b=sqrt((ww(l,1)-w(k,1)).^2+(ww(l,2)-w(k,2)).^2); 
            end 
        end 
    rhd = rhd + min_b; 
    end 
    rhd = rhd/tt;
MHD = max(fhd,rhd); 

EachImageData= MHD;

 

