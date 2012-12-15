function [I]=kmeansCOLOR(segments,I)

[x,y,z]=size(I);
W=zeros(x*y,5);
for i=1:y
    W(((i-1)*x)+1:i*x,2)=i;
end

for i=1:x*y
    W(i,1)=mod(i,x)+1;
    W(i,3)=I(mod(i,x)+1,W(i,2),1);
    W(i,4)=I(mod(i,x)+1,W(i,2),2);
    W(i,5)=I(mod(i,x)+1,W(i,2),3);
end

a=kmeans(W,segments);
rgb=zeros(1,segments,3);
count=zeros(segments,1);
rgb2=zeros(segments,3);

for i=1:x*y
    rgb(1,a(i),1)=rgb(1,a(i),1)+uint32(I(W(i,1),W(i,2),1));
    rgb(1,a(i),2)=rgb(1,a(i),2)+uint32(I(W(i,1),W(i,2),2));
    rgb(1,a(i),3)=rgb(1,a(i),3)+uint32(I(W(i,1),W(i,2),3));
    count(a(i))=count(a(i))+1;
end
for i=1:segments
    rgb2(i,1)=(rgb(1,i,1))/count(i);
    rgb2(i,2)=(rgb(1,i,2))/count(i);
    rgb2(i,3)=(rgb(1,i,3))/count(i);
end
for i=1:x*y
    I(W(i,1),W(i,2),1)=rgb2(a(i),1);
    I(W(i,1),W(i,2),2)=rgb2(a(i),2);
    I(W(i,1),W(i,2),3)=rgb2(a(i),3);
end