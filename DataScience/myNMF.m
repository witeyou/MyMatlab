% NMF算法模拟
% 输入: V原始矩阵
%      K目标降到的维数
% 输出: H降维后的矩阵
% $ V = W * H$

clc;
clear;

K = 3;    
load('../dataSet/cmcNew.mat','cmc');
class = cmc(:,10)';                   %原始矩阵类标号
V = cmc(:,1:9)';
clear cmc;

[M,N] = size(V);                      %样本个数N,特征个数M
W = rand(M,K);                        %初始的随机矩阵W
H = W\V;                              % $ H = W^{-1}V$
dist = norm(V-W*H,'fro');             % dist:损失值 利用了Frobenius 范数。
dist_new = dist+1;
count = 1;
while(abs(dist-dist_new)>0.0001)
    fprintf("\n this is %d times dis_old is %4f\t",count,dist);
    count = count+1;
    dist = dist_new;
    H = H.*((W'*V)./((W'*W)*H));      % 更新H
    W = W.*((V*H')./((W*H)*H'));      % 更新W
    dist_new = norm(V-W*H,'fro');     % 更新损失值
    fprintf("dis_new is %4f\tsub = %4f",dist_new,dist-dist_new);
end
% clear dist dist_new count
% 测试结果
scatter3(V(1,:),V(2,:),V(3,:),20,class*60,'filled');

