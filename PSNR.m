function [ psnr ] = PSNR( Org,Prc )
%PSNR 得到处理图像的峰值信噪比
%   Org为原图，Prc为处理后的图像
Org=double(Org);
Prc=double(Prc);
[height,width]=size(Org);
Dif_matrix=zeros(height,width);
Dif_matrix=Org-Prc;
MSE=sum(sum(Dif_matrix.*Dif_matrix))/(height*width);
if(MSE==0)
    psnr=0;
else
    psnr=10*log10((255*255)/MSE);
end



end

