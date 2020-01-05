% PCA算法模拟
% 输入: X原始矩阵
%      K目标降到的维数
% 输出: Y降维后的矩阵

clc;
clear;
K = 3;
load('../dataSet/iris_data.mat'); %这边导入样本
X = iris_data';
clear iris_data;

[M,N] = size(X);                   %样本个数记作N,特征个数记作M

% 原始矩阵中心化
for i =1:M
    X(i,:) = X(i,:)- mean(X(i,:));
end 
C = X*X';                          %计算散度矩阵
[V,D] = eig(C);                    %计算特征值及特征向量
[~,ind] = sort(diag(D),'descend');
Vsort = V(:,ind);                  %按特征值从大到小,对特征向量排序
P = Vsort(:,1:K)';
clear i V D ind Vsort;
Y = P*X;

% 测试 需要在K=3的情况下
hold on;
scatter3(Y(1,1:50),Y(2,1:50),Y(3,1:50),40,'r','filled');
scatter3(Y(1,51:100),Y(2,51:100),Y(3,1:50),40,'g','filled');
scatter3(Y(1,101:150),Y(2,101:150),Y(3,1:50),40,'b','filled');
hold off;
view(40,35);
% 测试结果一般

