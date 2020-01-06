% test myPCA()

clc;
clear;
load('../dataSet/iris_data.mat'); %这边导入样本
X = iris_data';
clear iris_data;
[Y,P] =myPCA(X,3);
% 测试 需要在K=3的情况下
hold on;
scatter3(Y(1,1:50),Y(2,1:50),Y(3,1:50),40,'r+');
scatter3(Y(1,51:100),Y(2,51:100),Y(3,1:50),40,'go');
scatter3(Y(1,101:150),Y(2,101:150),Y(3,1:50),40,'b*');
grid on;
hold off;
view(40,35);
