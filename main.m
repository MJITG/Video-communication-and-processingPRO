close all;
clear;
RefFid=fopen('H:\Astudy\��Ƶ������ͨ��\Pro\testSeq\sif_yuv_coastguard\coastguard\coastguard056.yuv','r');
CurFid=fopen('H:\Astudy\��Ƶ������ͨ��\Pro\testSeq\sif_yuv_coastguard\coastguard\coastguard058.yuv','r');
GrdFid=fopen('H:\Astudy\��Ƶ������ͨ��\Pro\testSeq\sif_yuv_coastguard\coastguard\coastguard057.yuv','r');
v_ht=288;%��
v_wd=352;%��

%����YUVÿһ������������
% yRef=zeros(v_ht,v_wd);
% yCur=zeros(v_ht,v_wd);

%�����д�����ά�����У�������
fseek(RefFid,0,'bof');
yRef(:,:)=fread(RefFid,[v_wd,v_ht],'uint8');
yRef=uint8(yRef);
yRef=yRef';
figure,imshow(yRef),title('RefFrame');
% fprintf('��ɶ�ȡ��%d/%d֡\n',frm,v_frm);

fseek(CurFid,0,'bof');
yCur(:,:)=fread(CurFid,[v_wd,v_ht],'uint8');
yCur=uint8(yCur);
yCur=yCur';
figure,imshow(yRef),title('CurFrame');

fseek(GrdFid,0,'bof');
yGrd(:,:)=fread(GrdFid,[v_wd,v_ht],'uint8');
yGrd=uint8(yGrd);
yGrd=yGrd';
figure,imshow(yGrd),title('Groundtruth');
% fprintf('��ɶ�ȡ��%d/%d֡\n',frm,v_frm);
% figure,imshow(yRef);
% figure,imshow(yCur);

[ mv_fld_x,mv_fld_y,~ ] = FullSearch(yRef,yCur);
VectorFieldFigure( mv_fld_x,mv_fld_y,8,v_ht,v_wd,'ǰ��δƽ��' );
[ fltrd_mv_field_x,fltrd_mv_field_y ] = PMVSv0_1( mv_fld_x,mv_fld_y );
VectorFieldFigure( fltrd_mv_field_x,fltrd_mv_field_y,8,v_ht,v_wd,'ǰ��ƽ��' );
[ForwardItpFrame,ForwardOcc] = PAMC_MC(yRef,yCur,fltrd_mv_field_x,fltrd_mv_field_y);
figure,imshow(ForwardItpFrame),title('Forward Interpolated Frame');
%ǰ�����
[ mv_fld_x,mv_fld_y,~ ] = FullSearch(yCur,yRef);
VectorFieldFigure( mv_fld_x,mv_fld_y,8,v_ht,v_wd,'����δƽ��' );
[ fltrd_mv_field_x,fltrd_mv_field_y ] = PMVSv0_1( mv_fld_x,mv_fld_y );
VectorFieldFigure( fltrd_mv_field_x,fltrd_mv_field_y,8,v_ht,v_wd,'����ƽ��' );
[BackwardItpFrame,BackwardOcc] = PAMC_MC(yCur,yRef,fltrd_mv_field_x,fltrd_mv_field_y);
figure,imshow(BackwardItpFrame),title('Backward Interpolated Frame');
%�������
[ CoItpFrame,CoOcc ] = PAMC_FB( ForwardOcc,BackwardOcc,ForwardItpFrame,BackwardItpFrame );
figure,imshow(CoItpFrame),title('Combined Interpolated Frame');
%ǰ��֡���
Frame=CoItpFrame(17:304,17:368);
occ=CoOcc(17:304,17:368);
[ Final,FinalOcc ]=IPHIv1( Frame,occ );
figure,imshow(Final),title('Unrefined Frame');
[ RefinedFrame,RefinedOcc ] = EdgeFill( Final,FinalOcc );
figure,imshow(RefinedFrame),title('Refined Frame');
% [ Frame9_fil ] = FrameGenerator( y(:,:,RefFrameNum),y(:,:,curFrameNum),fltrd_mv_field_x,fltrd_mv_field_y,block_size );
% [ Frame9 ] = FrameGenerator( y(:,:,RefFrameNum),y(:,:,curFrameNum),mv_fld_x,mv_fld_y,block_size );
[ psnr ] = PSNR( yGrd,RefinedFrame );
% [ psnr_fil ] = PSNR( y(:,:,frame),Frame9_fil );
psnr
% psnr_fil
% figure,imshow(Frame9),title('����֡');
% figure,imshow(Frame9_fil),title('ƽ����Ĳ���֡');
% [ R1,G1,B1,rgb1 ] = YUV420toRGB( y(:,:,RefFrameNum),u(:,:,RefFrameNum),v(:,:,RefFrameNum) );
% figure,imshow(rgb1);
% [ R2,G2,B2,rgb2 ] = YUV420toRGB( y(:,:,curFrameNum),u(:,:,curFrameNum),v(:,:,curFrameNum) );
% figure,imshow(rgb2);
% 
% 
% [ Ri ] = FrameGenerator( R1,R2,mv_fld_x,mv_fld_y,block_size );
% [ Gi ] = FrameGenerator( G1,G2,mv_fld_x,mv_fld_y,block_size );
% [ Bi ] = FrameGenerator( B1,B2,mv_fld_x,mv_fld_y,block_size );
% rgbData=zeros(v_ht,v_wd,3);
% rgbData=uint8(rgbData);
% rgbData(:,:,1)=Ri;
% rgbData(:,:,2)=Gi;
% rgbData(:,:,3)=Bi;
% figure,imshow(rgbData),title('δƽ��');
% 
% 
% [ fRi ] = FrameGenerator( R1,R2,fltrd_mv_field_x,fltrd_mv_field_y,block_size );
% [ fGi ] = FrameGenerator( G1,G2,fltrd_mv_field_x,fltrd_mv_field_y,block_size );
% [ fBi ] = FrameGenerator( B1,B2,fltrd_mv_field_x,fltrd_mv_field_y,block_size );
% frgbData=zeros(v_ht,v_wd,3);
% frgbData=uint8(frgbData);
% frgbData(:,:,1)=fRi;
% frgbData(:,:,2)=fGi;
% frgbData(:,:,3)=fBi;
% figure,imshow(frgbData),title('ƽ����');




