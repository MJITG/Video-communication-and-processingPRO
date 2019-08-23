function [ mv_fld_x,mv_fld_y, SAD_fld ] = FullSearch(refFrame,curFrame)
%FULLSEARCH ȫ����
% yΪ����ͼ��16Ϊ������Χ��8Ϊ���С��refFrameΪ�ο�֡��curFrameΪ��ǰ֡


% ��ȡ����ҶȾ���Ĵ�С
[height,width]=size(refFrame);
% fprintf('ԭ�D��%d, ��%d\n',height,width);

rv_width=width;
rv_height=height;

%��������y�����ž��󣬲���ǰһ֡�ͺ�һ֡��y�����м�
y_ext=zeros(rv_height+16*2,rv_width+16*2,2);
y_ext(16+1:height+16,16+1:width+16,1)=curFrame; %��ԭ�ȵ�ͼ��������ž����м�����Ͻǣ���ν�м䣬��ָ��ȥ���Ͽ�Ϊ��ߴ��һȦ��֡��
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
%ȫ����
mv_height=rv_height/8;
mv_width=rv_width/8;
mv_fld_x=zeros(mv_height,mv_width);
mv_fld_y=zeros(mv_height,mv_width);
SAD_fld=zeros(mv_height,mv_width);
for m=1:rv_width/8
    for n=1:rv_height/8
        MIN=100000000; %��ʼ����Сֵ
        %����ѭ���Ƕ�һ�����Ӧ�����˶�ʸ���ı���
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
%         fprintf('��%d�е�%d�п��MVΪ��%d,%d����SADΪ%d\n',n,m,min_yi,min_xi,MIN);

        mv_fld_x(n,m)=min_xi;
        mv_fld_y(n,m)=min_yi;
        SAD_fld(n,m)=SAD;
    end
end




end

