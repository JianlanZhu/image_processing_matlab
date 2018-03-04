%=======================digital_image_processing==========================

% 第五组组员：祝剑岚，陈思亮，赖奕敏，李江欣，吕佳静

% task1:实现直方图均衡化以及线性增强

% 遇到的问题的解决：
% 1.imshow函数的使用
% 2.数据类型转换

%============================直方图均衡化==================================
%已使用变量m,n,p,q,r,
clear;
syms row;   %行数
syms column;  %行、列数
syms newgray;  %统计新的灰度级数
newgray=1;

%---------------------------------------------
I=imread('头像2.jpg');
figure,imshow(I),title('原始图像');    %显示图像
I1=rgb2gray(I);      %转为灰度图像
figure,
subplot(2,1,1),imshow(I1);  %显示

%---------------灰度直方图实现------------------
[row,column]=size(I1);  %计算行列数
all=row*column;  %矩阵元素总数
s8=linspace(0,255,256);  %256-point processing
gray1=linspace(0,0,256);  %灰度直方图数据存储
for p=1:row
    for q=1:column
        gray1(I1(p,q)+1)=gray1(I1(p,q)+1)+1;
    end
end
gray1=gray1/all;   %注释掉此句可以查看灰度概率直方图
subplot(2,1,2),stem(s8,gray1,'Marker','none'),axis([0,256,0,inf]),
title('原始灰度直方图');  %有的灰度值出现很多

% figure,imhist(I1);%灰度直方图函数
% I2=histeq(I1); %用函数实现灰度直方图均衡
% figure,
% subplot(2,1,1),imshow(I2);
% subplot(2,1,2),imhist(I2);break

% ------------------均衡算法实现------------------------
skj=linspace(0,0,256);  %求变换函数sk
for m=1:256
    for r=1:m
        skj(m)=skj(m)+gray1(r);
    end
end
% figure,
% stem(s8,skj,'Marker','none'),title('sk计算(skj)');break

skb=linspace(1,1,256);  %求sk并
for m=1:256
    for r=1:255
        skb(m)=round(255*skj(m))/255;
    end
end
% figure,
% stem(s8,skb,'Marker','none'),title('sk并(skb)');break

sk=linspace(0,0,256);  %求sk
for m=1:255
    if skb(m)==skb(m+1)
        sk(m)=0;
    else
        newgray=newgray+1;
        sk(m)=skb(m);
    end
end
sk(256)=1;
% figure,
% subplot(2,1,1),stem(s8,sk,'Marker','none'),title('得到sk');break

nsk=linspace(0,0,256);  %求nsk累计
nsk=sk;
for m=1:255
    if nsk(256-m)==0
        nsk(256-m)=nsk(257-m);
    end
end
% subplot(2,1,2),stem(s8,nsk,'Marker','none'),title('得到nsk');break

I2=zeros(row,column);  %均衡化之后
for p=1:row
    for q=1:column
        I2(p,q)=nsk(I1(p,q)+1);
    end
end
% figure,imshow(I2),title('均衡后图像');

gray2=linspace(0,0,256);  %求均衡化后的灰度直方图
for p=1:row
    for q=1:column
        gray2(round(255*I2(p,q))+1)=gray2(round(255*I2(p,q))+1)+1;
    end
end
gray2=gray2/all;   

figure,
subplot(2,2,1),imshow(I1),title('原始图像');
subplot(2,2,2),imshow(I2),title('均衡后图像');
subplot(2,2,3),stem(s8,gray1,'Marker','none'),
axis([0,256,0,inf]),title('原始灰度直方图');
subplot(2,2,4),stem(s8,gray2,'Marker','none'),
axis([0,256,0,inf]),title('均衡后灰度直方图');
% figure,imhist(I2);  %使用函数产生灰度直方图

%========================线性增强算法实现================================
I3=ones(row,column);  %存储线性变换后图像
ma=max(max(I1));%找灰度最大的值
ma=double(ma);
mi=min(min(I1));  %找灰度最小的值
mi=double(mi);

I1d=I1;  %I1的double型矩阵
I1d=double(I1d);   %将灰度宽度拓展且反色
                   %若要查看可以使用max(max(I3))在命令行窗口中查看
for p=1:row
    for q=1:column
        I3(p,q)=255*(ma-I1d(p,q))/(ma-mi);
    end
end
I3=I3/255;
figure,
subplot(1,2,1),imshow(I1),title('原始图像');
subplot(1,2,2),imshow(I3),title('灰度宽度拓展且反色变换后图像');

