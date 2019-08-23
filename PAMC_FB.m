function [ CoItpFrame,CoOcc ] = PAMC_FB( ForwardOcc,BackwardOcc,ForwardItpFrame,BackwardItpFrame )
%PAMC_FB �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[height,width]=size(ForwardOcc);%�˴��Ѿ�����չ��Ե��Ĵ�С
CoOcc=ones(height,width);
CoItpFrame=zeros(height,width);
ForwardItpFrame=double(ForwardItpFrame);
BackwardItpFrame=double(BackwardItpFrame);

Both=find(ForwardOcc==1&BackwardOcc==1);
OnlyForward=find(ForwardOcc==1&BackwardOcc==0);
OnlyBackward=find(ForwardOcc==0&BackwardOcc==1);

CoOcc(ForwardOcc==0&BackwardOcc==0)=0;

CoItpFrame(Both)=(ForwardItpFrame(Both)+BackwardItpFrame(Both))./2;
CoItpFrame(OnlyForward)=ForwardItpFrame(OnlyForward);
CoItpFrame(OnlyBackward)=BackwardItpFrame(OnlyBackward);


CoItpFrame=uint8(CoItpFrame);
end

