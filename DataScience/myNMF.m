function [H,W] = myNMF(V,K)
% NMF算法模拟
% 输入: V原始矩阵   !注意!要求每一列是一个样本
%       K目标降到的维数
% 输出: H降维后的矩阵
% $ V = W * H$

[M,N] = size(V);                      %样本个数N,特征个数M
W = rand(M,K);                        %初始的随机矩阵W和H
H = rand(K,N);
dist = norm(V-W*H,'fro');             % dist:损失值 利用了Frobenius 范数。
dist_new = 0;
count = 1;

while(abs(1-dist/dist_new)>0.001)
    dist = dist_new;
    fprintf("\n %d times dist_old=%4f\t",count,dist);
    count = count+1;
    H = H.*((W'*V)./((W'*W)*H));      % 更新H
    W = W.*((V*H')./((W*H)*H'));      % 更新W
    dist_new = norm(V-W*H,'fro');     % 更新损失值
    fprintf("dist_new=%4f\t mis = %4f",dist_new,abs(1-dist/dist_new));
end
% clear dist dist_new count


