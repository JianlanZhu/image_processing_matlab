%=======================digital_image_processing==========================

% by 913104210135 祝剑岚

% 图像的膨胀与腐蚀算法

%================================主程序====================================
clear;
syms w1 db db1;     % w1为第一类出现的概率；
                    % db统计最大类间方差；
                    % db1为统计新类间方差，与原类间方差对比；
syms To;            % Otsu法阈值查找，存储当前最大阈值

%-----------------------------读图像-----------------------------------
I=imread('jay.jpg');
% figure,
% subplot(1,2,1),imshow(I),title('原始图像');  %显示图像
I1=rgb2gray(I);      %转为灰度图像
% subplot(1,2,2),imshow(I1),title('转为灰度图像');  %显示

[row,column]=size(I1);  %计算行列数
all=row*column;
s8=linspace(0,255,256);  %256-point processing
I1=double(I1);
I1=floor(I1/256);
T=sum(sum(I1))/row/column;
u=T;   %整体均值

%-----------------------先用OTSU法将图像转为两色----------------------------
% 先计算图像灰度直方图（灰度分布）方便后面计算概率
gray1=linspace(0,0,256);   % 灰度直方图数据存储
for p=1:row
    for q=1:column
        gray1(I1(p,q)+1)=gray1(I1(p,q)+1)+1;
    end
end
gray1=gray1/all;   % 概率形式灰度直方图
% figure,stem(s8,gray1,'Marker','none'),axis([0,256,0,inf]),
% title('灰度直方图');   % 画灰度直方图，有的灰度值出现很多

%--------------------------------------------------------------------------
To=0;   % 先将均值归零处理，基本不影响后面
w1=0;   % 第一部分概率
u1=0;   % 第一部分均值先归零
db=0;   % 与db1一起统计最大的类间方差
db1=0;
for m=1:256      % 遍历所有灰度找类间方差最大的
    w1=0;        % 为累加算第一部分做准备
    u1=0;        % 算第一部分均值
    
    for n=1:m    % 0到m-1灰度概率累加
        w1=w1+gray1(n);
    end
    
    if w1~=0 && w1~=1   % 分割的两部分不能有一个部分占了所有可能灰度
                        % 否则分割无意义，分割后全图只有单灰度
        for n=1:m
            u1=u1+(n-1)*gray1(n);   %计算第一部分i*pi求和
        end
        % 本步骤结束尚未得到第一部分均值，得到的是对应课件上的mu_t
        
        u2=(u-u1)/(1-w1);   % 第二部分均值计算完毕
        u1=u1/w1;           % 第一部分均值计算完毕
        db1=w1*(1-w1)*(u1-u2)^2;   % 计算类间方差
        
        if db1>=db    % 若新的类间方差比原有的大，则更新原有数值为新数值
            db=db1;   % 更新类间方差，为后面继续统计可能有更大的类间方差
            To=m;     % 更新阈值，由于此时已经发现满足类间方差更大的阈值
        end
    end
end

I3=ones(row,column);     % 图像分割后的存储矩阵
for p=1:row
    for q=1:column
        if I1(p,q)<=To   % 大于阈值幅值为1，否则为0
           I3(p,q)=0;
        else
           I3(p,q)=1;
        end
    end
end   
% figure,
% subplot(1,3,1),imshow(I),title('原始图像');        
% subplot(1,3,2),imshow(I1/255),title('转为灰度图像');  
% subplot(1,3,3),imshow(I3),title('Otsu阈值分割后图像');  
figure,
subplot(1,3,1),imshow(I3),title('原始二值图像');      %显示原始二值图像 

%---------------------------------膨胀-------------------------------------
%使用ppt上三个元素的结构
I4=I3;                                 %膨胀矩阵，处理边缘处和原图像相同
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
subplot(1,3,2),imshow(I4),title('膨胀后的图像');

%----------------------------------腐蚀-----------------------------------
I5=I3;                                %腐蚀矩阵，处理边缘处和原图像相同
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
subplot(1,3,3),imshow(I5),title('腐蚀后的图像');






