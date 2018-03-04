%=======================digital_image_processing==========================

% 第五组组员：祝剑岚，陈思亮，赖奕敏，李江欣，吕佳静

% task2:4点、8点平滑以及中值滤波

% 本实验加入椒盐噪声，理论上中值滤波效果最好

%===========================4&8点平滑=====================================
clear;
syms row;   %行数
syms column;  %行、列数

%-----------------------------读图像-----------------------------------
I=imread('lena.jpg');
I1=imnoise(I,'salt & pepper',0.01);  %加入椒盐噪声
% I1 = imnoise(I,'gaussian',0,0.005) %gauss
% figure,
% subplot(2,1.2),imshow(I),title('原始图像');    %显示图像
% I1=rgb2gray(I);      %转为灰度图像
figure,
subplot(1,2,1),imshow(I),title('原始图像');  %显示
subplot(1,2,2),imshow(I1),title('加入噪声后的图像');

[row,column]=size(I1);  %计算行列数
I1d=double(I1);

%----------------------4点平滑-------------------
I2=zeros(row,column);  %4点平滑存储
for p=2:(row-1)
    for q=2:(column-1)
        I2(p,q)=(I1d(p,q)+I1d(p,q-1)+I1d(p,q+1)+I1d(p-1,q)+I1d(p+1,q))/5;
    end
end
I2=I2/255;
figure
subplot(2,2,1),imshow(I1),title('未平滑图像');
subplot(2,2,2),imshow(I2),title('4点平滑后图像');

%----------------------8点平滑-------------------
I3=zeros(row,column);  %4点平滑存储
for p=2:(row-1)
    for q=2:(column-1)
        I3(p,q)=(I1d(p-1,q-1)+I1d(p-1,q)+I1d(p-1,q+1)+...
                 I1d(p,q-1)+I1d(p,q)+I1d(p,q+1)+...
                 I1d(p+1,q-1)+I1d(p+1,q)+I1d(p+1,q+1))/9;
    end
end
I3=I3/255;
subplot(2,2,3),imshow(I3),title('8点平滑后图像');

%---------------------中值滤波--------------------
I4=zeros(row,column);  %存储中值滤波后的值
zz=linspace(0,0,9);
syms z;

for p=2:(row-1)
    for q=2:(column-1)   %冒泡法排序
        zz(1)=I1d(p-1,q-1);zz(2)=I1d(p-1,q);zz(3)=I1d(p-1,q+1);...
        zz(4)=I1d(p,q-1);zz(5)=I1d(p,q);zz(6)=I1d(p,q+1);...
        zz(7)=I1d(p+1,q-1);zz(8)=I1d(p+1,q);zz(9)=I1d(p+1,q+1);
        for m=1:9
            for n=1:(9-m)
                if zz(n)>=zz(n+1)
                    z=zz(n);
                    zz(n)=zz(n+1);
                    zz(n+1)=z;
                end
            end 
        end
        I4(p,q)=zz(5);
    end
end
I4=I4/255;
subplot(2,2,4),imshow(I4),title('中值滤波后图像');

