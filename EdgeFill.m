function [ RefinedFrame,RefinedOcc ] = EdgeFill( Frame,occ )
%EDGEFILL 此处显示有关此函数的摘要
%   此处显示详细说明
RefinedFrame=Frame;
for i=4:-1:1
    holeLoc=find(occ(i,:)==0);
    [~,M]=size(holeLoc);
    for m=1:M
        RefinedFrame(i,holeLoc(m))=...
            median([RefinedFrame(i+1,holeLoc(m)),RefinedFrame(i+2,holeLoc(m)),...
            RefinedFrame(i+3,holeLoc(m))]);
        occ(i,holeLoc(m))=1;
    end
end
%up
for i=285:1:288
    holeLoc=find(occ(i,:)==0);
    [~,M]=size(holeLoc);
    for m=1:M
        RefinedFrame(i,holeLoc(m))=median([RefinedFrame(i-1,holeLoc(m)),...
            RefinedFrame(i-2,holeLoc(m)),RefinedFrame(i-3,holeLoc(m))]);
        occ(i,holeLoc(m))=1;
    end
end
%down
for i=4:-1:1
    holeLoc=find(occ(:,i)==0);
    [M,~]=size(holeLoc);
    for m=1:M
        RefinedFrame(holeLoc(m),i)=median([RefinedFrame(holeLoc(m),i+1),...
            RefinedFrame(holeLoc(m),i+2),RefinedFrame(holeLoc(m),i+3)]);
        occ(holeLoc(m),i)=1;
    end
end
%left
for i=349:1:352
    holeLoc=find(occ(:,i)==0);
    [M,~]=size(holeLoc);
    for m=1:M
        RefinedFrame(holeLoc(m),i)=median([RefinedFrame(holeLoc(m),i-1),...
            RefinedFrame(holeLoc(m),i-2),RefinedFrame(holeLoc(m),i-3)]);
        occ(holeLoc(m),i)=1;
    end
end
%right
RefinedOcc=occ;

end

