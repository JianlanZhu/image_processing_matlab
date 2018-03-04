%=======================digital_image_processing==========================

% task4:图像的自动阈值分割（迭代与Otsu)

% task5:膨胀与腐蚀算法实现

%===============================迭代法==================================
clear;
syms row column;  %行、列数
syms T T1 u1 n1 u2 n2;  % 自动阈值,u1、u2计算均值，n1、n2计算个数
syms w1 db db1;  %w1,w2为各类出现的概率；db类间方差；dw类内方差；
syms To;  %Otsu法阈值查找

%-----------------------------读图像-----------------------------------
I=imread('jay.jpg');
figure,
subplot(1,2,1),imshow(I),title('原始图像');  %显示图像
I1=rgb2gray(I);      %转为灰度图像
subplot(1,2,2),imshow(I1),title('转为灰度图像');  %显示

[row,column]=size(I1);  %计算行列数
all=row*column;
s8=linspace(0,255,256);  %256-point processing
I1=double(I1);
I1=floor(I1/256);
T=sum(sum(I1))/row/column;
u=T;   %整体均值

%-----------------------------迭代开始----------------------------------
u1=0;
u2=0;
n1=0;
n2=0;
for p=1:row
    for q=1:column
        if I1(p,q)<=T
            u1=u1+I1(p,q);
            n1=n1+1;
        else
            u2=u2+I1(p,q);
            n2=n2+1;
        end
    end
end
u1=u1/n1;
u2=u2/n2;
T1=round((u1+u2)/2);

while abs(T-T1)>1
    T=T1;
    u1=0;
    u2=0;
    n1=0;
    n2=0;
    for p=1:row
        for q=1:column
            if I1(p,q)<=T
                u1=u1+I1(p,q);
                n1=n1+1;
            else
                u2=u2+I1(p,q);
                n2=n2+1;
            end
        end
    end
    u1=u1/n1;
    u2=u2/n2;
    T1=round((u1+u2)/2);
end

I2=zeros(row,column);
for p=1:row
    for q=1:column
        if I1(p,q)<=T
           I2(p,q)=0;
        else
           I2(p,q)=1;
        end
    end
end
figure,
subplot(2,2,1),imshow(I1/255),title('原始图像');             
subplot(2,2,2),imshow(I2),title('迭代法阈值分割后图像');  

%==============================Ostu法===================================
gray1=linspace(0,0,256);  %灰度直方图数据存储
for p=1:row
    for q=1:column
        gray1(I1(p,q)+1)=gray1(I1(p,q)+1)+1;
    end
end
gray1=gray1/all;   %注释掉此句可以查看灰度概率直方图
% figure,stem(s8,gray1,'Marker','none'),axis([0,256,0,inf]),
% title('原始灰度直方图');  %有的灰度值出现很多

%-----------------------------
To=0;
w1=0;  %第一部分概率
u1=0;  %第一部分均值；u2为第二部分均值
db=0;
db1=0;
for m=1:256
    w1=0;
    u1=0;
    for n=1:m
        w1=w1+gray1(n);
    end
    if w1~=0 && w1~=1 
        for n=1:m
            u1=u1+(n-1)*gray1(n);
        end
        
        u2=(u-u1)/(1-w1);
        u1=u1/w1;
        
        db1=w1*(1-w1)*(u1-u2)^2;
        if db1>=db
            db=db1;
            To=m;
        end
    end
end


I3=ones(row,column);
for p=1:row
    for q=1:column
        if I1(p,q)<=To
           I3(p,q)=0;
        else
           I3(p,q)=1;
        end
    end
end
subplot(2,2,3),imshow(I1/255),title('原始图像');             
subplot(2,2,4),imshow(I3),title('Otsu阈值分割后图像');  

%==========================膨胀、腐蚀算法=================================
%使用ppt上三个元素的结构

I4=ones(row,column);  %膨胀矩阵
I5=zeros(row,column);  %腐蚀矩阵

for p=1:(row-1)
    for q=1:(column-1)
        if I3(p,q)==1
            if I3(p,q)+I3(p+1,q)+I3(p+1,q+1)~=3  %结构元素
                I4(p,q)=0;
            end
        else
            I4(p,q)=0;
        end
    end
end

for p=1:(row-1)
    for q=1:(column-1)
        if I3(p,q)==0
            if I3(p,q)+I3(p+1,q)+I3(p+1,q+1)~=0  %结构元素
                I5(p,q)=1;
            end
        else
            I5(p,q)=1;
        end
    end
end

figure,
subplot(1,3,1),imshow(I3),title('原始二值图像');             
subplot(1,3,2),imshow(I4),title('膨胀后的图像');  
subplot(1,3,3),imshow(I5),title('腐蚀后的图像');

    

            
            
            
            
            
            
            
            
            
            
            