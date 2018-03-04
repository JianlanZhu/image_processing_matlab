%=======================digital_image_processing==========================

% task4:ͼ����Զ���ֵ�ָ������Otsu)

% task5:�����븯ʴ�㷨ʵ��

%===============================������==================================
clear;
syms row column;  %�С�����
syms T T1 u1 n1 u2 n2;  % �Զ���ֵ,u1��u2�����ֵ��n1��n2�������
syms w1 db db1;  %w1,w2Ϊ������ֵĸ��ʣ�db��䷽�dw���ڷ��
syms To;  %Otsu����ֵ����

%-----------------------------��ͼ��-----------------------------------
I=imread('jay.jpg');
figure,
subplot(1,2,1),imshow(I),title('ԭʼͼ��');  %��ʾͼ��
I1=rgb2gray(I);      %תΪ�Ҷ�ͼ��
subplot(1,2,2),imshow(I1),title('תΪ�Ҷ�ͼ��');  %��ʾ

[row,column]=size(I1);  %����������
all=row*column;
s8=linspace(0,255,256);  %256-point processing
I1=double(I1);
I1=floor(I1/256);
T=sum(sum(I1))/row/column;
u=T;   %�����ֵ

%-----------------------------������ʼ----------------------------------
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
subplot(2,2,1),imshow(I1/255),title('ԭʼͼ��');             
subplot(2,2,2),imshow(I2),title('��������ֵ�ָ��ͼ��');  

%==============================Ostu��===================================
gray1=linspace(0,0,256);  %�Ҷ�ֱ��ͼ���ݴ洢
for p=1:row
    for q=1:column
        gray1(I1(p,q)+1)=gray1(I1(p,q)+1)+1;
    end
end
gray1=gray1/all;   %ע�͵��˾���Բ鿴�Ҷȸ���ֱ��ͼ
% figure,stem(s8,gray1,'Marker','none'),axis([0,256,0,inf]),
% title('ԭʼ�Ҷ�ֱ��ͼ');  %�еĻҶ�ֵ���ֺܶ�

%-----------------------------
To=0;
w1=0;  %��һ���ָ���
u1=0;  %��һ���־�ֵ��u2Ϊ�ڶ����־�ֵ
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
subplot(2,2,3),imshow(I1/255),title('ԭʼͼ��');             
subplot(2,2,4),imshow(I3),title('Otsu��ֵ�ָ��ͼ��');  

%==========================���͡���ʴ�㷨=================================
%ʹ��ppt������Ԫ�صĽṹ

I4=ones(row,column);  %���;���
I5=zeros(row,column);  %��ʴ����

for p=1:(row-1)
    for q=1:(column-1)
        if I3(p,q)==1
            if I3(p,q)+I3(p+1,q)+I3(p+1,q+1)~=3  %�ṹԪ��
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
            if I3(p,q)+I3(p+1,q)+I3(p+1,q+1)~=0  %�ṹԪ��
                I5(p,q)=1;
            end
        else
            I5(p,q)=1;
        end
    end
end

figure,
subplot(1,3,1),imshow(I3),title('ԭʼ��ֵͼ��');             
subplot(1,3,2),imshow(I4),title('���ͺ��ͼ��');  
subplot(1,3,3),imshow(I5),title('��ʴ���ͼ��');

    

            
            
            
            
            
            
            
            
            
            
            