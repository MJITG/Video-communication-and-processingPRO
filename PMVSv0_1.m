function [ fltrd_mv_field_x, fltrd_mv_field_y] = PMVSv0_1( mv_field_x,mv_field_y )
%PMVSv0.1采用欧式距离作为相似性度量
%   此处显示详细说明
[height,width]=size(mv_field_x(:,:));
fltrd_mv_field_x=mv_field_x;
fltrd_mv_field_y=mv_field_y;
for r=2:1:height-1
    for c=2:1:width-1
        CurWindow_x=mv_field_x(r-1:r+1,c-1:c+1);
        CurWindow_y=mv_field_y(r-1:r+1,c-1:c+1);
        CurWindowFltrd_x=fltrd_mv_field_x(r-1:r+1,c-1:c+1);
        CurWindowFltrd_y=fltrd_mv_field_y(r-1:r+1,c-1:c+1);
        Vpred_x=(CurWindowFltrd_x(1,1)+CurWindowFltrd_x(1,2)+CurWindowFltrd_x(2,1))/3;
        Vpred_y=(CurWindowFltrd_y(1,1)+CurWindowFltrd_y(1,2)+CurWindowFltrd_y(2,1))/3;
        CurWindowResidual_x=CurWindow_x(:,:)-Vpred_x;
        CurWindowResidual_y=CurWindow_y(:,:)-Vpred_y;
        EucDist=CurWindowResidual_x.^2+CurWindowResidual_y.^2;
        [~,loci,locj] = minmax(EucDist,4);
        fltrd_mv_field_x(r,c)=(CurWindow_x(loci(1),locj(1))+CurWindow_x(loci(2),locj(2))...
                              +CurWindow_x(loci(3),locj(3))+CurWindow_x(loci(4),locj(4)))/4;
        fltrd_mv_field_y(r,c)=(CurWindow_y(loci(1),locj(1))+CurWindow_y(loci(2),locj(2))...
                              +CurWindow_y(loci(3),locj(3))+CurWindow_y(loci(4),locj(4)))/4;
    end
end
end


