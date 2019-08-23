function [  ] = VectorFieldFigure( vector_x,vector_y,block_size,height,width,Title )
%VECTORFIELDFIGURE ���ݿ��С���˶������Ƴ�ʸ��ͼ
%   



%�����Ƶ���ǿ�ߴ��������������������Ŀ�
if(mod(width,block_size)~=0)
    rv_width=((width-mod(width,block_size))/block_size+1)*block_size;
else
    rv_width=width;
end
%�����Ƶ�߲��ǿ�ߴ��������������������ĸ�
if(mod(height,block_size)~=0)
    rv_height=((height-mod(height,block_size))/block_size+1)*block_size;
else
    rv_height=height;
end

field_height=rv_height/block_size;
field_width=rv_width/block_size;

[x,y]=meshgrid(1:field_width,1:field_height);


figure,quiver(x,y,vector_x,flipud(vector_y)),title(Title);

end

