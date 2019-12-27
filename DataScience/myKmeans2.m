clc;
clear;
K = 3;    %这边用来设置K的初始值
load('../dataSet/iris_data.mat'); %这边导入样本
X = iris_data';
clear iris_data;
%列数是样本个数记作N,行数是样本的特征个数记作M
[M,N] = size(X);

RandNoK = floor(rand(1,K)*N); %RandNoK为 1xK 的K个随机数
centerMat = X(:,RandNoK);     %初始的K个中心
clcMat = cat(1,X,zeros(1,N)); %最底下加了一列用来等会存类簇信息

% 设置最大迭代次数20
for time=1:20
    fprintf("\t  this is  %d times  \n",time);
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
    centerMatNew = zeros(M+1,K);  %最后一行是计数用的
    % 计算新的聚类中心
    for i=1:N
        for j=1:K
            if clcMat(M+1,i)==j
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
    if diffMat==0
        disp("算法结束");
        break;
    else
        disp("开始下一轮");
        centerMat = centerMatNew(1:M,:);
    end
end
clear i j centerMat centerMatNew diffMat time tmp disTmpMat;


% % 正确率判断,不通用
% aaa = clcMat(M+1,1:50);
% bbb = clcMat(M+1,50:100);
% ccc = clcMat(M+1,100:150);
% mis = length(find(aaa~=mode(aaa)))+length(find(bbb~=mode(bbb)))+length(find(ccc~=mode(ccc)));
% clear aaa bbb ccc;
% disp(mis); 
% disp((150-mis)/150);