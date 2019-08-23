function [ CoItpFrame,CoOcc ] = PAMC_FB( ForwardOcc,BackwardOcc,ForwardItpFrame,BackwardItpFrame )
%PAMC_FB 此处显示有关此函数的摘要
%   此处显示详细说明
[height,width]=size(ForwardOcc);%此处已经是扩展边缘后的大小
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

