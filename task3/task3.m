%=======================digital_image_processing==========================

% 第五组组员：祝剑岚，陈思亮，赖奕敏，李江欣，吕佳静

% task3:简单锐化（简单梯度算法，ROBERTS算子）及拉普拉斯算子锐化

% Prewitt & Sobel

%============================简单锐化======================================
clear;
syms row;   %行数
syms column;  %行、列数
syms x y T;

%-----------------------------读图像-----------------------------------
I1=imread('lena.jpg');
% figure,,imshow(I),title('原始图像');    %显示图像
% I1=rgb2gray(I);      %转为灰度图像
% figure,imshow(I1),title('原始图像');  %显示

[row,column]=size(I1);  %计算行列数
I1d=double(I1);  %类型转换
T=sum(sum(I1d))/row/column;

%-----------------------------水平操作---------------------------------
figure,
subplot(2,2,1),imshow(I1),title('原始图像');

I2=zeros(row,column);  %水平操作存储
for p=1:row
    for q=2:column
        I2(p,q)=abs(I1d(p,q)-I1d(p,q-1))/255;
    end
end
subplot(2,2,2),imshow(I2),title('水平操作');

%-----------------------------垂直操作-------------------------------
I3=zeros(row,column);  %垂直操作存储
for p=2:row
    for q=1:column
        I3(p,q)=abs(I1d(p,q)-I1d(p-1,q))/255;
    end
end
subplot(2,2,3),imshow(I3),title('垂直操作');

%-----------------------------梯度操作-------------------------------
I5=zeros(row,column);  %梯度操作存储
for p=2:row
    for q=2:column
        x=abs(I1d(p,q)-I1d(p-1,q));
        y=abs(I1d(p,q)-I1d(p,q-1));
        if x>=y
            I5(p,q)=x;
        else
            I5(p,q)=y;
        end;
%         if x+y>T
%             I5(p,q)=x+y;
%         else
%             I5(p,q)=I1d(p,q);
%         end
    end
end
I5=I5/255;
subplot(2,2,4),imshow(I1d/255+I5),title('梯度操作');

%-----------------------------Roberts算子------------------------------
figure,
subplot(1,2,1),imshow(I1),title('原始图像');

I6=zeros(row,column);  %Roberts算子操作存储
for p=2:row
    for q=2:column
        x=abs(I1d(p,q)-I1d(p-1,q-1));
        y=abs(I1d(p,q-1)-I1d(p-1,q));
%         if x>=y
%             I6(p,q)=x;
%         else
%             I6(p,q)=y;
%         end
        I6(p,q)=x+y;  %采用直接相加的方法
    end
end
I6=I6/255;
subplot(1,2,2),imshow(I1d/255+I6),title('Roberts算子操作');

%----------------------Prewitt & Sobel 算法---------------------------------
Ip=zeros(row,column);  %Prewitt 算法操作存储
Is=zeros(row,column);  %Sobel 算法操作存储

for p=2:(row-1)
    for q=2:(column-1)
        x=abs(I1d(p-1,q-1)+I1d(p-1,q)+I1d(p-1,q+1)-...
                 I1d(p+1,q-1)-I1d(p+1,q)-I1d(p+1,q+1));
        y=abs(I1d(p-1,q-1)-I1d(p-1,q+1)+I1d(p,q-1)-I1d(p,q+1)+...
                 I1d(p+1,q-1)-I1d(p+1,q+1));
        Ip(p,q)=(x^2+y^2)^(1/2);  %不采用简便式
    end
end
Ip=Ip/255;

for p=2:(row-1)
    for q=2:(column-1)
        x=abs(I1d(p-1,q-1)+2*I1d(p-1,q)+I1d(p-1,q+1)-...
                 I1d(p+1,q-1)-2*I1d(p+1,q)-I1d(p+1,q+1));
        y=abs(I1d(p-1,q-1)-I1d(p-1,q+1)+2*I1d(p,q-1)-2*I1d(p,q+1)+...
                 I1d(p+1,q-1)-I1d(p+1,q+1));
        Is(p,q)=(x^2+y^2)^(1/2);  %不采用简便式
    end
end
Is=Is/255;

figure,
subplot(1,3,1),imshow(I1),title('原始图像');
subplot(1,3,2),imshow(I1d/255+Ip),title('Prewitt算法操作');
subplot(1,3,3),imshow(I1d/255+Is),title('Sobel算法操作');

%==========================拉普拉斯算子锐化===========================
I7=zeros(row,column);  %拉普拉斯算子操作存储
for p=2:(row-1)
    for q=2:(column-1)
        I7(p,q)=4*I1d(p,q)-I1d(p-1,q)-I1d(p+1,q)-I1d(p,q-1)-I1d(p,q+1);
    end
end
I7=I7/255;
figure,
subplot(1,2,1),imshow(I1),title('原始图像');
subplot(1,2,2),imshow(I1d/255+I7),title('拉普拉斯算子增强');  
























