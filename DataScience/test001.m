clc;
clear;
K = 3;
load('E:\MyMatlab\dataSet\iris_data.mat');
[heigth,width] = size(iris_data);
initPointNO = floor(rand(1,K,"single")*heigth);

initMat = zeros(K,width);

fid = fopen('./DataScience/test001.txt','w');

fprintf(fid,"initial K's point \n")
% for i=1:K
%     fprintf(fid,"%f    %f   %f   %f\n",iris_data(initPoint(1,i),:));
%     initMat(i,:)=initMat(i,:)+iris_data(initPoint(1,i),:);
% %     iris_data(i,:);
% end

initMat = [iris_data(25,:);iris_data(75,:);iris_data(125,:)] %找出初始的K个样本
initMat = [iris_data(initPointNO(1,1),:);iris_data(initPointNO(1,2),:);iris_data(initPointNO(1,3),:)]

targetMat = initMat

% initMat = cat(2,initMat,[0;0;0;0])

for times=1:20
    fprintf(fid," %d times iteration\n",times);
    fprintf(" %d times iteration\n",times);
    %给每一行(每一个样本)分类
    for i=1:heigth   
        disMat = zeros(1,K);%存放与k个点距离的行向量
        fprintf(fid,"No:%d\t sample is %f    %f   %f   %f ---->\t",i,iris_data(i,:));
        for j=1:K
            tmp1 = iris_data(i,:)-initMat(j,:);
            disMat(1,j) = tmp1*tmp1';%计算到每一个初始中心点的距离
        end
%         fprintf(fid,"\t\tdisMat's %f    %f   %f   %f  ",disMat);
%         fprintf(fid,"\n\t\t|min %f  ||",min(disMat));
        switch(min(disMat))
            case disMat(1)
                fprintf(fid,"this is 1 class\n");
                targetMat(1,:) = (targetMat(1,:)+iris_data(i,:))/2;
            case disMat(2)
                fprintf(fid,"this is 2 class\n");
                targetMat(2,:) = (targetMat(2,:)+iris_data(i,:))/2;
            case disMat(3)
                fprintf(fid,"this is 3 class\n");
                targetMat(3,:) = (targetMat(3,:)+iris_data(i,:))/2;
            otherwise
                fprintf(fid,"not found\n");
        end
    end
    %输出本次计算的结果
    for i=1:K
        fprintf(fid,"target %d is %f    %f   %f   %f\n",i,targetMat(i,:));
        fprintf("target %d is %f    %f   %f   %f\n",i,targetMat(i,:));
    end
    if initMat == targetMat
        fprintf(fid," \n!!!!have found res !!!!\n");
        break;
    end
    initMat = targetMat;
end

%mtalab 内建函数的测试
fprintf(fid,"\n\n________________built in function kmeans_______________\n\n");
[Idx,Ctrs,SumD,D] = kmeans(iris_data,3);

for i=1:K
    fprintf(fid,"point %d is %f    %f   %f   %f\n",i,Ctrs(i,:));
end

fprintf(fid,"\n\nclass\t||\tdistence1\t||\tdistence2\t||\tdistence3\t\n");

for i = 1:heigth
    fprintf(fid,"\t%d\t||\t%f\t||\t%f\t||\t%f\t\n",Idx(i,1),D(i,1),D(i,2),D(i,3));
end

fclose(fid);