%% test myNMF() 1
clc;
clear;
    
load('../dataSet/cmcNew.mat','cmc');
class = cmc(:,10)';                   %原始矩阵类标号
V = cmc(:,1:9)';
clear cmc;

[H,W] = myNMF(V,3);

% 测试结果
scatter3(V(1,:),V(2,:),V(3,:),20,class*60,'filled');

%% 2
clc;
clear;
load('../dataSet/iris_data.mat'); %这边导入样本
X = iris_data';
clear iris_data;
[Y,P] =myNMF(X,3);
% 测试 需要在K=3的情况下
hold on;
scatter3(Y(1,1:50),Y(2,1:50),Y(3,1:50),40,'r+');
scatter3(Y(1,51:100),Y(2,51:100),Y(3,1:50),40,'go');
scatter3(Y(1,101:150),Y(2,101:150),Y(3,1:50),40,'b*');
grid on;
hold off;
view(40,35);

X_s = X';
Y_s = Y';
fprintf("\n ----original data----------------------- new data---- \n")
for i = 1:length(X_s)
    for j = 1:4
    fprintf("% 5.2f|",X_s(i,j));
    end
        fprintf("<----->|");
    for j = 1:3
    fprintf("% 5.2f|",Y_s(i,j));
    end
    fprintf("\n");
end
