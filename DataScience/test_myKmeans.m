clear;
clc;
K = 3;    %这边用来设置K的初始值
load('../dataSet/iris_data.mat'); %这边导入样本
X = iris_data';
X = X(:,1:3:150); 
Y = myKmeans(X,K);


X_s = X';
Y_s = Y';
fprintf("\n ----original data----------------------- new data---- \n")
for i = 1:length(X_s)
    for j = 1:4
    fprintf("% 5.2f|",X_s(i,j));
    end
        fprintf("<----->|");
    for j = 1:4
    fprintf("% 5.2f|",Y_s(i,j));
    end
    fprintf(" belonged %d class\n",int8(Y_s(i,5)));
end