%% 灰色关联度分析
function [result, z] = huise(x)
    %%  对变量预处理，去量纲
    % 求每个指标的均值
    x_mean = mean(x);
    pro_mean = x  ./ repmat(x_mean, size(x, 1), 1);
    %% 计算子序列中各指标与母序列的相关系数
    mother = pro_mean(:, 1);
    son = pro_mean(:, 2:end);
    relation = abs(son - repmat(mother, 1, size(x, 2) -1));
    %% 求两极最大和最小差
    Max_r = max(max(relation));
    Min_r = min(min(relation));
    p = 0.5;
    z = (Min_r + p * Max_r) ./ (abs(relation) + p * Max_r);
    result = mean(z);
end