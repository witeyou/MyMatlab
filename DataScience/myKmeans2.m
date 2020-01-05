% 模拟K-means算法
% 输入:待分类矩阵X.(每一列为一个样本,每一行为一个属性)
%      分类数:K
% 输出:分好类的矩阵Y:在X矩阵的最后加上一行,存储了类标号

% 设置算法输入X,K
clc;
clear;
K = 3;    %这边用来设置K的初始值
load('../dataSet/iris_data.mat'); %这边导入样本
X = iris_data';
clear iris_data;

[M,N] = size(X);                  % M:样本属性数    N:样本个数
% 取得随机的初始K个中心,拼接成centerMat
RandNoK = floor(rand(1,K)*N);     % RandNoK为 1xK 的K个随机数
centerMat = X(:,RandNoK);         % 根据随机值取得的初始的K个中心

clcMat = cat(1,X,zeros(1,N));     % X矩阵最底下加了一行用来等会存储类簇信息

% 设置最大迭代次数20
for time=1:20
    fprintf("\t  this is  %d times  \n",time);
    % step1:计算每个样本到K个中心的距离,并分类
    for i=1:N                     
        disTmpMat = zeros(1,K);   % (1*K)的矩阵.临时存放到K个中心的距离
        for j = 1:K
            tmp = clcMat(1:M,i)-centerMat(1:M,j);
            disTmpMat(1,j) = tmp'*tmp;
        end
        clcMat(M+1,i) = find(disTmpMat==min(disTmpMat),1);  
        % 这个小技巧可以记录一下,在一个行向量中找到最小的一个值的位置
        % 这边结束clcMat的最后一行已经添加上了类标号
    end
    
    % step2:计算新的聚类中心
    centerMatNew = zeros(M+1,K);  %用于计算新的聚类中心,最后一行是计数用的
    for i=1:N
        for j=1:K
            if clcMat(M+1,i)==j   %clcMat的最后一行是类簇标号
                centerMatNew(:,j)= centerMatNew(:,j)+cat(1,clcMat(1:M,i),1);
            end
        end
    end
    for i=1:K
        centerMatNew(:,i)=centerMatNew(:,i)/centerMatNew(M+1,i);
    end
    
    % 判断是否到达预期,继续迭代
    diffMat = centerMatNew(1:M,:)-centerMat;
    disp(diffMat);
    if diffMat==0                 % 聚类中心已经不在改变
        disp("complete");
        break;
    else
        disp("next times");
        centerMat = centerMatNew(1:M,:);
    end
end
Y = clcMat;
clear i j centerMat centerMatNew diffMat time tmp disTmpMat clcMat;



% % 正确率判断,不通用
% aaa = clcMat(M+1,1:50);
% bbb = clcMat(M+1,50:100);
% ccc = clcMat(M+1,100:150);
% mis = length(find(aaa~=mode(aaa)))+length(find(bbb~=mode(bbb)))+length(find(ccc~=mode(ccc)));
% clear aaa bbb ccc;
% disp(mis); 
% disp((150-mis)/150);