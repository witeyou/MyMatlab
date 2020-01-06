function [Y,P] = myPCA(X,K)
% PCA算法模拟
% 输入: X原始矩阵   !注意!要求每一列是一个样本
%       K目标降到的维数
% 输出: Y降维后的矩阵
%       P降维使用的投影矩阵

[M,~] = size(X);                   %样本个数记作N,特征个数记作M

% 原始矩阵中心化
for i =1:M
    X(i,:) = X(i,:)- mean(X(i,:));
end 
C = X*X';                          %计算散度矩阵
[V,D] = eig(C);                    %计算特征值及特征向量
[~,ind] = sort(diag(D),'descend');
Vsort = V(:,ind);                  %按特征值从大到小,对特征向量排序
P = Vsort(:,1:K)';                 %选取前K个特征值并转置
clear i V D ind Vsort;
Y = P*X;

