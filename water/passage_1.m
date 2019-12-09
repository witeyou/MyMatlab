
%% CLAHE的测试
I = imread('tire.tif');
J = adapthisteq(I,'clipLimit',0.02,'Distribution','rayleigh');
imshowpair(I,J,'montage');
title('Original Image (left) and Contrast Enhanced Image (right)')

%% 图像压缩并切分RGB通道+普通HE处理RGB三通道
clear;
I0 = imread('pic4.jpg');
I = imresize(I0,[256 256]);
IR = I(:,:,1);
IG = I(:,:,2);
IB = I(:,:,3);

% 普通HE处理
IR2 = histeq(IR);
IG2 = histeq(IG);
IB2 = histeq(IB);

% subplot(3,3,2);imshow(I0);
% subplot(3,3,5);imshow(I);
% subplot(3,3,7);imshow(IR);
% subplot(3,3,8);imshow(IG);
% subplot(3,3,9);imshow(IB);

% CLAHE处理
IR3 = adapthisteq(IR2,'NumTiles',[3 3],'clipLimit',0.01,'Range','original','Distribution','exponential','Alpha',0.1);
IG3 = adapthisteq(IG2,'NumTiles',[3 3],'clipLimit',0.01,'Range','original','Distribution','exponential','Alpha',0.1);
IB3 = adapthisteq(IB2,'NumTiles',[3 3],'clipLimit',0.01,'Range','original','Distribution','exponential','Alpha',0.1);

% rst pic
pic_clahe = cat(3,IR3,IG3,IB3);
imshowpair(I,pic_clahe,'montage');

% subplot(2,3,2);imshow(I);
% subplot(2,3,4);imshow(IR);
% subplot(2,3,5);imshow(IG);
% subplot(2,3,6);imshow(IB);

% subplot(2,3,1);imshow(IR);
% subplot(2,3,2);imshow(IG);
% subplot(2,3,3);imshow(IB);
% subplot(2,3,4);imshow(IR2);
% subplot(2,3,5);imshow(IG2);
% subplot(2,3,6);imshow(IB2);

% subplot(2,3,1);imshow(IR2);
% subplot(2,3,2);imshow(IG2);
% subplot(2,3,3);imshow(IB2);
% subplot(2,3,4);imshow(IR3);
% subplot(2,3,5);imshow(IG3);
% subplot(2,3,6);imshow(IB3);



%% 普通HE测试
clear;
I = imread('lena.jpeg');
J = histeq(I);
imshowpair(I,J,'montage')

%% PSNR计算测试
clc;
clear;
ref = imread('lena.jpeg');
A = histeq(ref);
imshowpair(A,ref,'montage');
peaksnr = psnr(A,ref);
fprintf('\n the psnr is %0.4f',peaksnr);

%% 信息熵计算
I = imread('lena.jpeg');
J = entropy(I);
fprintf('\n the entropy is %0.4f',J);
