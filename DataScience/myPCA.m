% PCA算法模拟
clc;
clear;
K = 3;    %这边用来目标降到的维数
load('../dataSet/iris_data.mat'); %这边导入样本
X = iris_data';
clear iris_data;
%列数是样本个数记作N,行数是样本的特征个数记作M
[M,N] = size(X);
% centering
for i =1:M
    X(i,:) = X(i,:)- mean(X(i,:));
end 
C = X*X';
[V,D] = eig(C);
V = V';
V = cat(2,zeros(M,1),V);
for i = 1:M
    V(:,1) = V(:,1)+D(:,i);
end
V = sortrows(V,'descend');
P = V(1:K,2:M+1);
X_new = P*X;
clear i C V D P

% % 测试 需要在K=2的情况下
% hold on;
% scatter(X_new(1,1:50),X_new(2,1:50),20,'r','filled');
% scatter(X_new(1,51:100),X_new(2,51:100),20,'g','filled');
% scatter(X_new(1,101:150),X_new(2,101:150),20,'b','filled');
% hold off;
% % 测试结果不是很好

% 测试 需要在K=3的情况下
hold on;
scatter3(X_new(1,1:50),X_new(2,1:50),X_new(3,1:50),40,'r','filled');
scatter3(X_new(1,51:100),X_new(2,51:100),X_new(3,1:50),40,'g','filled');
scatter3(X_new(1,101:150),X_new(2,101:150),X_new(3,1:50),40,'b','filled');
hold off;
view(40,35);
% 测试结果一般

% todo :用cmc那个数据集进行测试
