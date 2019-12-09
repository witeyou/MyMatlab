%% 图像压缩并切分RGB通道+普通HE处理RGB三通道
clc;
clear;
I0 = imread('pic5.jpg');
I0 = imresize(I0,[256 256]);
I1 = imread('pic5.jpg');
I1 = imresize(I1,[256 256]);
IR0 = I0(:,:,1);
IG0 = I0(:,:,2);
IB0 = I0(:,:,3);
IR1 = I1(:,:,1);
IG1 = I1(:,:,2);
IB1 = I1(:,:,3);

% 普通HE处理
% IR0_he = histeq(IR0);
% IG0_he = histeq(IG0);
% IB0_he = histeq(IB0);
IR1_he = histeq(IR1);
IG1_he = histeq(IG1);
IB1_he = histeq(IB1);

% CLAHE处理
IR0_clahe = adapthisteq(IR0,'NumTiles',[8 8],'clipLimit',0.02);
IG0_clahe = adapthisteq(IG0,'NumTiles',[8 8],'clipLimit',0.02);
IB0_clahe = adapthisteq(IB0,'NumTiles',[8 8],'clipLimit',0.02);
IR1_clahe = adapthisteq(IR1_he*0.8,'NumTiles',[3 3],'clipLimit',0.01,'Range','original','Distribution','exponential','Alpha',0.1);
IG1_clahe = adapthisteq(IG1_he,'NumTiles',[3 3],'clipLimit',0.01,'Range','original','Distribution','exponential','Alpha',0.1);
IB1_clahe = adapthisteq(IB1_he,'NumTiles',[3 3],'clipLimit',0.01,'Range','original','Distribution','exponential','Alpha',0.1);
% IR1_clahe = adapthisteq(IR0,'NumTiles',[3 3],'clipLimit',0.01,'Range','original','Distribution','exponential','Alpha',0.1);
% IG1_clahe = adapthisteq(IG0,'NumTiles',[3 3],'clipLimit',0.01,'Range','original','Distribution','exponential','Alpha',0.1);
% IB1_clahe = adapthisteq(IB0,'NumTiles',[3 3],'clipLimit',0.01,'Range','original','Distribution','exponential','Alpha',0.1);


% rst pic
% pic0_he = cat(3,IR0_he,IG0_he,IB0_he);
% pic1_he = cat(3,IR1_he,IG1_he,IB1_he);
pic0_clahe = cat(3,IR0_clahe,IG0_clahe,IB0_clahe);% 普通clahe
pic1_clahe = cat(3,IR1_clahe,IG1_clahe,IB1_clahe);% 本文方法
pic0_he = cat(3,IR1_he,IG1_he,IB1_he);            % 普通HE

% 计算信息熵
fprintf('\t the pic0         entropy is %0.4f \n',entropy(I0));
fprintf('\t the my method    entropy is %0.4f \n',entropy(pic1_clahe));
fprintf('\t the HE           entropy is %0.4f \n',entropy(pic0_he));
fprintf('\t the CLAHE-common entropy is %0.4f \n',entropy(pic0_clahe));

% 计算MSE
fprintf('\n\t the my method    MSE is %0.4f \n',immse(pic1_clahe,I0));
fprintf('\t the HE           MSE is %0.4f \n',immse(pic0_he,I0));
fprintf('\t the CLAHE-common MSE is %0.4f \n',immse(pic0_clahe,I0));

% 计算PSNR
fprintf('\n\t the my method    PSNR is %0.4f \n',psnr(pic1_clahe,I0));
fprintf('\t the HE           PSNR is %0.4f \n',psnr(pic0_he,I0));
fprintf('\t the CLAHE-common PSNR is %0.4f \n',psnr(pic0_clahe,I0));

subplot(1,4,1);imshow(I0);
subplot(1,4,2);imshow(pic0_he);
subplot(1,4,3);imshow(pic0_clahe);
subplot(1,4,4);imshow(pic1_clahe);
% subplot(2,3,4);imshow(I1);
% subplot(2,3,5);imshow(pic1_he);
% subplot(2,3,6);imshow(pic1_clahe);
