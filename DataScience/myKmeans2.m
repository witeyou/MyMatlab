clc;
clear;
K = 3;    %这边用来设置K的初始值
load('../dataSet/iris_data.mat');
X = iris_data';
clear iris_data;
%列数是样本个数记作N,行数是样本的特征个数记作M
[M,N] = size(X);

RandNoK = floor(rand(1,K)*N); %RandNoK为 1xK 的K个随机数
centerMat = X(:,RandNoK);     %初始的K个中心
clcMat = cat(1,X,zeros(1,N)); %最底下加了一列用来等会存类簇信息

% 设置最大迭代次数20
for time=1:1
    for i=1:N
        disTmpMat = zeros(1,K); %临时存放到K个中心的距离
        % 计算出到K个中心的距离
        for j = 1:K
            tmp = clcMat(1:M,i)-centerMat(1:M,j);
            disTmpMat(1,j) = tmp'*tmp;
        end
        clcMat(M+1,i) = find(disTmpMat==min(disTmpMat),1);  
        % 这个小技巧可以记录一下,在一个行向量中找到最小的一个值的位置
        % 这边结束clcMat的最后一行已经添加上了类标号
    end
    centerMatNew = zeros(M,K);
end