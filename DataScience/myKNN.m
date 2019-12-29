% 最近邻算法模拟
clc;
clear;

K = 5;    %这边用来设置K的初始值
load('../dataSet/iris_data.mat'); %这边导入样本
X = iris_data';
clear iris_data;
%列数是样本个数记作N,行数是样本的特征个数记作M
[M,N] = size(X);
% 最后一行打上标签 !!!
X = cat(1,X,cat(2,ones(1,50),ones(1,50)*2,ones(1,50)*3)); 

trainSet = X(:,1:2:N);
testSet = X(:,2:2:N);

% last row store the distence per time
trainSet = cat(1,trainSet,zeros(1,length(trainSet)));
% last row store caculated class per simple
testSet = cat(1,testSet,zeros(1,length(testSet)));
for i = 1:length(testSet)
    for j = 1:length(trainSet)
        tmp = testSet(1:M,i) - trainSet(1:M,j);
        trainSet(M+2,j) = tmp'*tmp;
    end
    % the last row of trainSet is the distence between sample and trainSet
    trainSet = sortrows(trainSet',M+2)';
    classNo = mode(trainSet(M+1,1:K));
    testSet(M+2,i) = classNo;
    trainSet(M+2,:) = 0;
end
clear classNo i j tmp

% effect test
diff = find(testSet(M+1,:)-testSet(M+2,:));
fprintf("total is %d\t mistake is %d \t correct rat is %f",length(testSet),length(diff),(1-length(diff)/length(testSet))*100)