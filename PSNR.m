function [ psnr ] = PSNR( Org,Prc )
%PSNR �õ�����ͼ��ķ�ֵ�����
%   OrgΪԭͼ��PrcΪ������ͼ��
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

