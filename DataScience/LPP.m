function [eigvector, eigvalue] = LPP(W, options, data)
% LPP: Locality Preserving Projections
%
%       [eigvector, eigvalue] = LPP(W, options, data)
% 
%             Input:
%               data       - Data matrix. Each row vector of fea is a data point.
%               W       - Affinity matrix. You can either call "constructW"
%                         to construct the W, or construct it by yourself.
%               options - Struct value in Matlab. The fields in options
%                         that can be set:
%                           
%                         Please see LGE.m for other options.
%
%             Output:
%               eigvector - Each column is an embedding function, for a new
%                           data point (row vector) x,  y = x * eigvector
%                           will be the embedding result of x.
%               eigvalue  - The sorted eigvalue of LPP eigen-problem. 
% 
%
%    Examples:
%
%       fea = rand(50,70);
%       options = [];
%       options.Metric = 'Euclidean';
%       options.NeighborMode = 'KNN';
%       options.k = 5;
%       options.WeightMode = 'HeatKernel';
%       options.t = 5;
%       W = constructW(fea,options);
%       options.PCARatio = 0.99
%       [eigvector, eigvalue] = LPP(W, options, fea);
%       Y = fea * eigvector;
%         
%       fea = rand(50,70);
%       gnd = [ones(10,1);ones(15,1)*2;ones(10,1)*3;ones(15,1)*4];
%       options = [];
%       options.Metric = 'Euclidean';
%       options.NeighborMode = 'Supervised';
%       options.gnd = gnd;
%       options.bLDA = 1;
%       W = constructW(fea,options);      
%       options.PCARatio = 1;
%       [eigvector, eigvalue] = LPP(W, options, fea);
%       Y = fea*eigvector;
% 
% 
% Note: After applying some simple algebra, the smallest eigenvalue problem:
%				data^T*L*data = \lemda data^T*D*data
%      is equivalent to the largest eigenvalue problem:
%				data^T*W*data = \beta data^T*D*data
%		where L=D-W;  \lemda= 1 - \beta.
% Thus, the smallest eigenvalue problem can be transformed to a largest 
% eigenvalue problem. Such tricks are adopted in this code for the 
% consideration of calculation precision of Matlab.
% 
%
% See also constructW, LGE
%
%Reference:
%	Xiaofei He, and Partha Niyogi, "Locality Preserving Projections"
%	Advances in Neural Information Processing Systems 16 (NIPS 2003),
%	Vancouver, Canada, 2003.
%
%   Xiaofei He, Shuicheng Yan, Yuxiao Hu, Partha Niyogi, and Hong-Jiang
%   Zhang, "Face Recognition Using Laplacianfaces", IEEE PAMI, Vol. 27, No.
%   3, Mar. 2005. 
%
%   Deng Cai, Xiaofei He and Jiawei Han, "Document Clustering Using
%   Locality Preserving Indexing" IEEE TKDE, Dec. 2005.
%
%   Deng Cai, Xiaofei He and Jiawei Han, "Using Graph Model for Face Analysis",
%   Technical Report, UIUCDCS-R-2005-2636, UIUC, Sept. 2005
% 
%	Xiaofei He, "Locality Preserving Projections"
%	PhD's thesis, Computer Science Department, The University of Chicago,
%	2005.
%
%   version 2.1 --June/2007 
%   version 2.0 --May/2007 
%   version 1.1 --Feb/2006 
%   version 1.0 --April/2004 
%
%   Written by Deng Cai (dengcai2 AT cs.uiuc.edu)
%

if (~exist('options','var'))
   options = [];
end

[nSmp,nFea] = size(data);
if size(W,1) ~= nSmp
    error('W and data mismatch!');
end

%====================================================
% If data is too large, the following centering codes can be commented 
% options.keepMean = 1;
%====================================================
if isfield(options,'keepMean') && options.keepMean
    ;
else
    %判断是否是稀疏矩阵,如果是则将其展开
    if issparse(data)
        data = full(data);
    end
    sampleMean = mean(data);% data每一列的均值
    data = (data - repmat(sampleMean,nSmp,1));% 将上一行的均值向量复制到完整大小并作减,最终实现data的中心化
end
%====================================================

D = full(sum(W,2));% 可同时应对稀释矩阵和普通矩阵

if ~isfield(options,'Regu') || ~options.Regu
    DToPowerHalf = D.^.5;
    D_mhalf = DToPowerHalf.^-1; % D^{-1/2}
    % 这个东西的作用好像是取W的标准化
    if nSmp < 5000
        tmpD_mhalf = repmat(D_mhalf,1,nSmp);
        W = (tmpD_mhalf .* W) .* tmpD_mhalf';
        clear tmpD_mhalf;
    else
        [i_idx,j_idx,v_idx] = find(W);% 根据权重矩阵W,找到所有邻接的边
        v1_idx = zeros(size(v_idx));
        for i=1:length(v_idx)
            v1_idx(i) = v_idx(i) * D_mhalf(i_idx(i)) * D_mhalf(j_idx(i));
        end
        W = sparse(i_idx,j_idx,v1_idx);
        clear i_idx j_idx v_idx v1_idx
    end
    W = max(W,W');
    % 这边出来的是标准化的W
    data = repmat(DToPowerHalf,1,nFea) .* data;
    % 参考LGE函数具体实现
    [eigvector, eigvalue] = LGE(W, [], options, data);
else
    options.ReguAlpha = options.ReguAlpha*sum(D)/length(D);

    D = sparse(1:nSmp,1:nSmp,D,nSmp,nSmp);
    [eigvector, eigvalue] = LGE(W, D, options, data);
end

eigIdx = find(eigvalue < 1e-3);% 找到特征值为0的位置
eigvalue (eigIdx) = [];% 剔除为0的特征值及其对应的特征向量
eigvector(:,eigIdx) = [];

