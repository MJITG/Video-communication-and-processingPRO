function [ mv_fld_x,mv_fld_y, SAD_fld ] = FullSearch(refFrame,curFrame)
%FULLSEARCH 全搜索
% y为输入图像，16为搜索范围，8为块大小，refFrame为参考帧，curFrame为当前帧


% 获取输入灰度矩阵的大小
[height,width]=size(refFrame);
% fprintf('原圖高%d, 寬%d\n',height,width);

rv_width=width;
rv_height=height;

%生成两个y的扩张矩阵，并将前一帧和后一帧的y放入中间
y_ext=zeros(rv_height+16*2,rv_width+16*2,2);
y_ext(16+1:height+16,16+1:width+16,1)=curFrame; %将原先的图像放入扩张矩阵中间的左上角，所谓中间，是指除去加上宽为块尺寸的一圈的帧。
y_ext(16+1:height+16,16+1:width+16,2)=refFrame;

% y_ext(1:16,:,1)=repmat(y_ext(17,:,1),16,1);
% y_ext(height+17:height+32,:,1)=repmat(y_ext(304,:,1),16,1);
% y_ext(:,1:16,1)=repmat(y_ext(:,17,1),1,16);
% y_ext(:,width+17:width+32,1)=repmat(y_ext(:,368,1),1,16);
% 
% y_ext(1:16,:,2)=repmat(y_ext(17,:,2),16,1);
% y_ext(height+17:height+32,:,2)=repmat(y_ext(304,:,2),16,1);
% y_ext(:,1:16,2)=repmat(y_ext(:,17,2),1,16);
% y_ext(:,width+17:width+32,2)=repmat(y_ext(:,368,2),1,16);
%全搜索
mv_height=rv_height/8;
mv_width=rv_width/8;
mv_fld_x=zeros(mv_height,mv_width);
mv_fld_y=zeros(mv_height,mv_width);
SAD_fld=zeros(mv_height,mv_width);
for m=1:rv_width/8
    for n=1:rv_height/8
        MIN=100000000; %初始化最小值
        %以下循环是对一个块对应所有运动矢量的遍历
        for xi=-16:16
            for yi=-16:16
                SAD=0;
                abs_residual=abs(y_ext(16+(n-1)*8+1+yi:16+n*8+yi,16+(m-1)*8+1+xi:16+m*8+xi,2)...
                    -y_ext(16+(n-1)*8+1:16+n*8,16+(m-1)*8+1:16+m*8,1));
                SAD=sum(sum(abs_residual));
                if (SAD<MIN)
                    MIN=SAD;
                    min_xi=xi;
                    min_yi=yi;
                end
            end
        end
%         fprintf('第%d行第%d列块的MV为（%d,%d），SAD为%d\n',n,m,min_yi,min_xi,MIN);

        mv_fld_x(n,m)=min_xi;
        mv_fld_y(n,m)=min_yi;
        SAD_fld(n,m)=SAD;
    end
end




end

