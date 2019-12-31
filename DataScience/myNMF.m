% 模拟NMF--非负矩阵分解
clc;
clear;

K = 3;    %这边用来设置K--目的维数
% load('../dataSet/cmc.mat'); %这边导入样本
% V = cmc;
% clear cmc;
load('../dataSet/new_breast_cancer_wisconsin.mat');
X = new_breast_cancer_wisconsin(:,1:10);
class = new_breast_cancer_wisconsin(:,11)';
V = X';
clear X;
%列数是样本个数记作N,行数是样本的特征个数记作M
[M,N] = size(V);
%初始的随机矩阵W
W = rand(M,K)*100;
H = W\V;% $ H = W^{-1}V$
distence = trace((V-W*H)'*(V-W*H));
distence_new = distence+1;
count = 1;
while(abs(distence-distence_new)>0.001)
    fprintf("\n this is %d times dis_old is %4f\t",count,distence);
    count = count+1;
    distence = distence_new;
    H = H.*((W'*V)./((W'*W)*H));
    W = W.*((V*H')./((W*H)*H'));
    distence_new = trace((V-W*H)*(V-W*H)');
    fprintf("dis_new is %4f\tsub = %4f",distence_new,distence-distence_new);
end
clear distence distence_new count
% hold on;
% scatter3(V(1,1:459),V(2,1:459),V(3,1:459),'r','filled');
% scatter3(V(1,460:699),V(2,460:699),V(3,460:699),'b','filled');
% hold off;
scatter3(V(1,:),V(2,:),V(3,:),20,class*60,'filled');