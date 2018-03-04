%=======================digital_image_processing==========================

% ��������Ա��ף��ᰣ���˼��������������������Ѿ�

% task2:4�㡢8��ƽ���Լ���ֵ�˲�

% ��ʵ����뽷����������������ֵ�˲�Ч�����

%===========================4&8��ƽ��=====================================
clear;
syms row;   %����
syms column;  %�С�����

%-----------------------------��ͼ��-----------------------------------
I=imread('lena.jpg');
I1=imnoise(I,'salt & pepper',0.01);  %���뽷������
% I1 = imnoise(I,'gaussian',0,0.005) %gauss
% figure,
% subplot(2,1.2),imshow(I),title('ԭʼͼ��');    %��ʾͼ��
% I1=rgb2gray(I);      %תΪ�Ҷ�ͼ��
figure,
subplot(1,2,1),imshow(I),title('ԭʼͼ��');  %��ʾ
subplot(1,2,2),imshow(I1),title('�����������ͼ��');

[row,column]=size(I1);  %����������
I1d=double(I1);

%----------------------4��ƽ��-------------------
I2=zeros(row,column);  %4��ƽ���洢
for p=2:(row-1)
    for q=2:(column-1)
        I2(p,q)=(I1d(p,q)+I1d(p,q-1)+I1d(p,q+1)+I1d(p-1,q)+I1d(p+1,q))/5;
    end
end
I2=I2/255;
figure
subplot(2,2,1),imshow(I1),title('δƽ��ͼ��');
subplot(2,2,2),imshow(I2),title('4��ƽ����ͼ��');

%----------------------8��ƽ��-------------------
I3=zeros(row,column);  %4��ƽ���洢
for p=2:(row-1)
    for q=2:(column-1)
        I3(p,q)=(I1d(p-1,q-1)+I1d(p-1,q)+I1d(p-1,q+1)+...
                 I1d(p,q-1)+I1d(p,q)+I1d(p,q+1)+...
                 I1d(p+1,q-1)+I1d(p+1,q)+I1d(p+1,q+1))/9;
    end
end
I3=I3/255;
subplot(2,2,3),imshow(I3),title('8��ƽ����ͼ��');

%---------------------��ֵ�˲�--------------------
I4=zeros(row,column);  %�洢��ֵ�˲����ֵ
zz=linspace(0,0,9);
syms z;

for p=2:(row-1)
    for q=2:(column-1)   %ð�ݷ�����
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
subplot(2,2,4),imshow(I4),title('��ֵ�˲���ͼ��');

