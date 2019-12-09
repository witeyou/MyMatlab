clc;
clear;
K = 3;
load('E:\MyMatlab\dataSet\iris_data.mat');
[heigth,width] = size(iris_data);
[Idx,Ctrs,SumD,D] = kmeans(iris_data,K);

for i=1:K
    fprintf(fid,"第%d质心位置    %f    %f   %f   %f\n",Ctrs(i,:));
end

fprintf(fid,"\t分类\t|||\t距离1\t||\t距离2\t||\t距离3\t");

for i = 1:heigth
    fprintf(fid,"\t%f\t|||\t%f\t||\t%f\t||\t%f\t",Idx(i,1),D(i,1),D(i,2),D(i,3));
end
