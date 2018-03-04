%=======================digital_image_processing==========================

% ��������Ա��ף��ᰣ���˼��������������������Ѿ�

% task1:ʵ��ֱ��ͼ���⻯�Լ�������ǿ

% ����������Ľ����
% 1.imshow������ʹ��
% 2.��������ת��

%============================ֱ��ͼ���⻯==================================
%��ʹ�ñ���m,n,p,q,r,
clear;
syms row;   %����
syms column;  %�С�����
syms newgray;  %ͳ���µĻҶȼ���
newgray=1;

%---------------------------------------------
I=imread('ͷ��2.jpg');
figure,imshow(I),title('ԭʼͼ��');    %��ʾͼ��
I1=rgb2gray(I);      %תΪ�Ҷ�ͼ��
figure,
subplot(2,1,1),imshow(I1);  %��ʾ

%---------------�Ҷ�ֱ��ͼʵ��------------------
[row,column]=size(I1);  %����������
all=row*column;  %����Ԫ������
s8=linspace(0,255,256);  %256-point processing
gray1=linspace(0,0,256);  %�Ҷ�ֱ��ͼ���ݴ洢
for p=1:row
    for q=1:column
        gray1(I1(p,q)+1)=gray1(I1(p,q)+1)+1;
    end
end
gray1=gray1/all;   %ע�͵��˾���Բ鿴�Ҷȸ���ֱ��ͼ
subplot(2,1,2),stem(s8,gray1,'Marker','none'),axis([0,256,0,inf]),
title('ԭʼ�Ҷ�ֱ��ͼ');  %�еĻҶ�ֵ���ֺܶ�

% figure,imhist(I1);%�Ҷ�ֱ��ͼ����
% I2=histeq(I1); %�ú���ʵ�ֻҶ�ֱ��ͼ����
% figure,
% subplot(2,1,1),imshow(I2);
% subplot(2,1,2),imhist(I2);break

% ------------------�����㷨ʵ��------------------------
skj=linspace(0,0,256);  %��任����sk
for m=1:256
    for r=1:m
        skj(m)=skj(m)+gray1(r);
    end
end
% figure,
% stem(s8,skj,'Marker','none'),title('sk����(skj)');break

skb=linspace(1,1,256);  %��sk��
for m=1:256
    for r=1:255
        skb(m)=round(255*skj(m))/255;
    end
end
% figure,
% stem(s8,skb,'Marker','none'),title('sk��(skb)');break

sk=linspace(0,0,256);  %��sk
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
% subplot(2,1,1),stem(s8,sk,'Marker','none'),title('�õ�sk');break

nsk=linspace(0,0,256);  %��nsk�ۼ�
nsk=sk;
for m=1:255
    if nsk(256-m)==0
        nsk(256-m)=nsk(257-m);
    end
end
% subplot(2,1,2),stem(s8,nsk,'Marker','none'),title('�õ�nsk');break

I2=zeros(row,column);  %���⻯֮��
for p=1:row
    for q=1:column
        I2(p,q)=nsk(I1(p,q)+1);
    end
end
% figure,imshow(I2),title('�����ͼ��');

gray2=linspace(0,0,256);  %����⻯��ĻҶ�ֱ��ͼ
for p=1:row
    for q=1:column
        gray2(round(255*I2(p,q))+1)=gray2(round(255*I2(p,q))+1)+1;
    end
end
gray2=gray2/all;   

figure,
subplot(2,2,1),imshow(I1),title('ԭʼͼ��');
subplot(2,2,2),imshow(I2),title('�����ͼ��');
subplot(2,2,3),stem(s8,gray1,'Marker','none'),
axis([0,256,0,inf]),title('ԭʼ�Ҷ�ֱ��ͼ');
subplot(2,2,4),stem(s8,gray2,'Marker','none'),
axis([0,256,0,inf]),title('�����Ҷ�ֱ��ͼ');
% figure,imhist(I2);  %ʹ�ú��������Ҷ�ֱ��ͼ

%========================������ǿ�㷨ʵ��================================
I3=ones(row,column);  %�洢���Ա任��ͼ��
ma=max(max(I1));%�һҶ�����ֵ
ma=double(ma);
mi=min(min(I1));  %�һҶ���С��ֵ
mi=double(mi);

I1d=I1;  %I1��double�;���
I1d=double(I1d);   %���Ҷȿ����չ�ҷ�ɫ
                   %��Ҫ�鿴����ʹ��max(max(I3))�������д����в鿴
for p=1:row
    for q=1:column
        I3(p,q)=255*(ma-I1d(p,q))/(ma-mi);
    end
end
I3=I3/255;
figure,
subplot(1,2,1),imshow(I1),title('ԭʼͼ��');
subplot(1,2,2),imshow(I3),title('�Ҷȿ����չ�ҷ�ɫ�任��ͼ��');

