%=======================digital_image_processing==========================

% ��������Ա��ף��ᰣ���˼��������������������Ѿ�

% task3:���񻯣����ݶ��㷨��ROBERTS���ӣ���������˹������

% Prewitt & Sobel

%============================����======================================
clear;
syms row;   %����
syms column;  %�С�����
syms x y T;

%-----------------------------��ͼ��-----------------------------------
I1=imread('lena.jpg');
% figure,,imshow(I),title('ԭʼͼ��');    %��ʾͼ��
% I1=rgb2gray(I);      %תΪ�Ҷ�ͼ��
% figure,imshow(I1),title('ԭʼͼ��');  %��ʾ

[row,column]=size(I1);  %����������
I1d=double(I1);  %����ת��
T=sum(sum(I1d))/row/column;

%-----------------------------ˮƽ����---------------------------------
figure,
subplot(2,2,1),imshow(I1),title('ԭʼͼ��');

I2=zeros(row,column);  %ˮƽ�����洢
for p=1:row
    for q=2:column
        I2(p,q)=abs(I1d(p,q)-I1d(p,q-1))/255;
    end
end
subplot(2,2,2),imshow(I2),title('ˮƽ����');

%-----------------------------��ֱ����-------------------------------
I3=zeros(row,column);  %��ֱ�����洢
for p=2:row
    for q=1:column
        I3(p,q)=abs(I1d(p,q)-I1d(p-1,q))/255;
    end
end
subplot(2,2,3),imshow(I3),title('��ֱ����');

%-----------------------------�ݶȲ���-------------------------------
I5=zeros(row,column);  %�ݶȲ����洢
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
subplot(2,2,4),imshow(I1d/255+I5),title('�ݶȲ���');

%-----------------------------Roberts����------------------------------
figure,
subplot(1,2,1),imshow(I1),title('ԭʼͼ��');

I6=zeros(row,column);  %Roberts���Ӳ����洢
for p=2:row
    for q=2:column
        x=abs(I1d(p,q)-I1d(p-1,q-1));
        y=abs(I1d(p,q-1)-I1d(p-1,q));
%         if x>=y
%             I6(p,q)=x;
%         else
%             I6(p,q)=y;
%         end
        I6(p,q)=x+y;  %����ֱ����ӵķ���
    end
end
I6=I6/255;
subplot(1,2,2),imshow(I1d/255+I6),title('Roberts���Ӳ���');

%----------------------Prewitt & Sobel �㷨---------------------------------
Ip=zeros(row,column);  %Prewitt �㷨�����洢
Is=zeros(row,column);  %Sobel �㷨�����洢

for p=2:(row-1)
    for q=2:(column-1)
        x=abs(I1d(p-1,q-1)+I1d(p-1,q)+I1d(p-1,q+1)-...
                 I1d(p+1,q-1)-I1d(p+1,q)-I1d(p+1,q+1));
        y=abs(I1d(p-1,q-1)-I1d(p-1,q+1)+I1d(p,q-1)-I1d(p,q+1)+...
                 I1d(p+1,q-1)-I1d(p+1,q+1));
        Ip(p,q)=(x^2+y^2)^(1/2);  %�����ü��ʽ
    end
end
Ip=Ip/255;

for p=2:(row-1)
    for q=2:(column-1)
        x=abs(I1d(p-1,q-1)+2*I1d(p-1,q)+I1d(p-1,q+1)-...
                 I1d(p+1,q-1)-2*I1d(p+1,q)-I1d(p+1,q+1));
        y=abs(I1d(p-1,q-1)-I1d(p-1,q+1)+2*I1d(p,q-1)-2*I1d(p,q+1)+...
                 I1d(p+1,q-1)-I1d(p+1,q+1));
        Is(p,q)=(x^2+y^2)^(1/2);  %�����ü��ʽ
    end
end
Is=Is/255;

figure,
subplot(1,3,1),imshow(I1),title('ԭʼͼ��');
subplot(1,3,2),imshow(I1d/255+Ip),title('Prewitt�㷨����');
subplot(1,3,3),imshow(I1d/255+Is),title('Sobel�㷨����');

%==========================������˹������===========================
I7=zeros(row,column);  %������˹���Ӳ����洢
for p=2:(row-1)
    for q=2:(column-1)
        I7(p,q)=4*I1d(p,q)-I1d(p-1,q)-I1d(p+1,q)-I1d(p,q-1)-I1d(p,q+1);
    end
end
I7=I7/255;
figure,
subplot(1,2,1),imshow(I1),title('ԭʼͼ��');
subplot(1,2,2),imshow(I1d/255+I7),title('������˹������ǿ');  
























