clear;
clc;
I = imread('pic5.jpg');
% 割通道
IR = I(:,:,1);
IG = I(:,:,2);
IB = I(:,:,3);
% he处理
IR_he = histeq(IR);
IG_he = histeq(IG);
IB_he = histeq(IB);
%clahe
IR_clahe = adapthisteq(IR_he,'NumTiles',[3 3],'clipLimit',0.01,'Range','original','Distribution','exponential','Alpha',0.1);
IG_clahe = adapthisteq(IG_he,'NumTiles',[3 3],'clipLimit',0.01,'Range','original','Distribution','exponential','Alpha',0.1);
IB_clahe = adapthisteq(IB_he,'NumTiles',[3 3],'clipLimit',0.01,'Range','original','Distribution','exponential','Alpha',0.1);
% 合成图像
pic_clahe = cat(3,IR_clahe,IG_clahe,IB_clahe);
% 显示
% subplot(2,4,1);imhist(IR,128);
% %subplot(2,4,1);histogram(IR,'DisplayStyle','stairs','FaceAlpha',0.6);
% subplot(2,4,2);imhist(IG,128);
% subplot(2,4,3);imhist(IB,128);
% subplot(2,4,4);imhist(I,128);
% subplot(2,4,5);imhist(IR_clahe,128);
% subplot(2,4,6);imhist(IG_clahe,128);
% subplot(2,4,7);imhist(IB_clahe,128);
% subplot(2,4,8);imhist(pic_clahe,128);

% 用于显示直方图比较结果
subplot(2,2,1);imshow(I);
subplot(2,2,2);imshow(pic_clahe);
subplot(2,2,3);
histogram(IR,128,'DisplayStyle','stairs','EdgeColor','r');hold on;
histogram(IG,128,'DisplayStyle','stairs','EdgeColor','g');hold on;
histogram(IB,128,'DisplayStyle','stairs','EdgeColor','b');hold off;
subplot(2,2,4);
histogram(IR_clahe,128,'DisplayStyle','stairs','EdgeColor','r');hold on;
histogram(IG_clahe,128,'DisplayStyle','stairs','EdgeColor','g');hold on;
histogram(IB_clahe,128,'DisplayStyle','stairs','EdgeColor','b');hold off;