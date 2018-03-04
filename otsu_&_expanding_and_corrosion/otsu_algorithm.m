%=======================digital_image_processing==========================

% by 祝剑岚
% Otsu图像分割算法

% 注：每次程序运行完毕后可以通过查看工作区里的To值来查看该图的分割阈值，
%     也可以查看u来观察图像整体均值

%-------------------------------参数的设置---------------------------------
clear;
syms w1 db db1;     % w1为第一类出现的概率；
                    % db统计最大类间方差；
                    % db1为统计新类间方差，与原类间方差对比；
syms To;            % Otsu法阈值查找，存储当前最大阈值

%--------------------------------读图像------------------------------------
I=imread('jay.jpg');      % 读入（彩色）图像
I1=rgb2gray(I);           % 转为灰度图像
                          % 读入彩色图像需要先转为灰度图像
[row,column]=size(I1);    % 计算行列数
all=row*column;           % 计算矩阵总元素个数
s8=linspace(0,255,256);   %256点处理横坐标
I1=double(I1);            % 双精度度化矩阵
I1=floor(I1/256);    % 若原图为16为整型数据类型需要加这句话，
                     % 把0到2^16-1的取值范围转为2^8-1，
                     % 这样下面就可以可以和8位整型时的图像同样先处理了。
                     % 原来我读入的jay.jpg是16位的所以加了这句话。
                     % floor为向负无穷取整函数，即向下取整
u=sum(sum(I1))/row/column;   % 计算整体灰度均值 

%===============================Ostu法=====================================
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
figure,
subplot(1,3,1),imshow(I),title('原始图像');        
subplot(1,3,2),imshow(I1/255),title('转为灰度图像');  
subplot(1,3,3),imshow(I3),title('Otsu阈值分割后图像');  

