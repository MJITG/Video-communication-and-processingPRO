close all;
clear;
v_ht=288;%高
v_wd=352;%宽
testSeq='football';
PSNR_Vector=zeros(300,1);

for i=2:124
    yRef=zeros(v_wd,v_ht);
    yCur=zeros(v_wd,v_ht);
    yGrd=zeros(v_wd,v_ht);
    RefFid=fopen(['H:\Astudy\视频处理与通信\Pro\testSeq\sif_yuv_',testSeq,'\',testSeq,'\','fb',num2str(i+1,'%03d'),'.yuv'],'r');
    CurFid=fopen(['H:\Astudy\视频处理与通信\Pro\testSeq\sif_yuv_',testSeq,'\',testSeq,'\','fb',num2str(i-1,'%03d'),'.yuv'],'r');
    GrdFid=fopen(['H:\Astudy\视频处理与通信\Pro\testSeq\sif_yuv_',testSeq,'\',testSeq,'\','fb',num2str(i,'%03d'),'.yuv'],'r');
   
    fseek(RefFid,0,'bof');
    yRef(:,:)=fread(RefFid,[v_wd,v_ht],'uint8');
    yRef=uint8(yRef);
    yRef=yRef';
    
    fseek(CurFid,0,'bof');
    yCur(:,:)=fread(CurFid,[v_wd,v_ht],'uint8');
    yCur=uint8(yCur);
    yCur=yCur';
    
    fseek(GrdFid,0,'bof');
    yGrd(:,:)=fread(GrdFid,[v_wd,v_ht],'uint8');
    yGrd=uint8(yGrd);
    yGrd=yGrd';
    
    [ mv_fld_x,mv_fld_y,~ ] = FullSearch(yRef,yCur);
    [ fltrd_mv_field_x,fltrd_mv_field_y ] = PMVSv0_1( mv_fld_x,mv_fld_y );
    [ForwardItpFrame,ForwardOcc] = PAMC_MC(yRef,yCur,fltrd_mv_field_x,fltrd_mv_field_y);
    %前向估计
    [ mv_fld_x,mv_fld_y,~ ] = FullSearch(yCur,yRef);
    [ fltrd_mv_field_x,fltrd_mv_field_y ] = PMVSv0_1( mv_fld_x,mv_fld_y );
    [BackwardItpFrame,BackwardOcc] = PAMC_MC(yCur,yRef,fltrd_mv_field_x,fltrd_mv_field_y);
    %后向估计
    [ CoItpFrame,CoOcc ] = PAMC_FB( ForwardOcc,BackwardOcc,ForwardItpFrame,BackwardItpFrame );
    %前后帧组合
    Frame=CoItpFrame(17:304,17:368);
    occ=CoOcc(17:304,17:368);
    [ Final,FinalOcc ]=IPHIv1( Frame,occ );
    [ RefinedFrame,RefinedOcc ] = EdgeFill( Final,FinalOcc );
    [ PSNR_Vector(i+1,1) ] = PSNR( yGrd,RefinedFrame );
    fprintf([num2str(i-1,'%03d'),' finished']);
    PSNR_Vector(i+1,1)
    
    fclose(RefFid);
    fclose(CurFid);
    fclose(GrdFid);
    
end