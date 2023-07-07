%% 熵权法 算权重
function [score, weights] = shangquan(x)
%实现用熵值法求各指标(列）的权重及各数据行的得分
%x为原始数据矩阵, 一行代表一个样本, 每列对应一个指标
%type指示向量，1表示正向指标，2表示负向指标
%score 返回各行（样本）得分，weights 返回各列权重

%%数据的归一化处理
X(:, 1) = guiyi(x(:, 1), 2, 0.002, 0.996);    %若归一化到[0,1], 0会出问题
X(:, 2) = guiyi(x(:, 2), 2, 0.002, 0.996);
X(:, 3) = guiyi(x(:, 3), 1, 0.002, 0.996);

%%计算第j个指标下，第i个样本占该指标的比重p(i,j)
for i = 1 : 402
    for j = 1 : 3
        p(i, j) = X(i, j) / sum(X(:, j));
    end
end

%%计算第j个指标的熵值e(j)
k = 1 / log(402);
for j = 1 : 3
    e(j) = -k * sum(p(:, j) .* log(p(:, j)));
end
%计算信息熵冗余度
d = ones(1, 3) - e; 
%求权值w
weights = d ./ sum(d);
%求综合得分
score = 100 * weights * X';
end