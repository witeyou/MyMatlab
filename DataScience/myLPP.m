clear;
clc;
K = 3;    %这边用来设置K近邻的初始值
load('../dataSet/iris_data.mat'); %这边导入样本
X = iris_data';
X = X(:,1:2:150); 
clear iris_data; 
[M,N] = size(X); %N个样本,M个属性

% 计算到每个样本的距离
dist_all = [];
dist_sort_all = [];
for i =1:N
    tmp = zeros(N,1);
    for j = 1:N
        tmp(j,1) = norm(X(:,i)-X(:,j));
    end
    [tmp_sort,ind] = sort(tmp);
    dist_all = [dist_all,tmp];
    dist_sort_all = [dist_sort_all,ind];
end
