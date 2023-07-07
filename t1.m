%% 计算每个供应商的重要性
order = xlsread('..\附件1 近5年402家供应商的相关数据.xlsx', '企业的订货量（m³）', 'B2:IH403');
supply = xlsread('..\附件1 近5年402家供应商的相关数据.xlsx', '供应商的供货量（m³）', 'B2:IH403');
delivery_all = zeros(402, 1);
supply_all = zeros(402, 1);
cost = order(:, 1);
%聚类结果
load('predict.mat');
for i = 1:402
    supply_all(i) = sum(supply(i, :));
    for j = 1:240
        delivery_all(i) = delivery_all(i) + abs(supply(i, j) - order(i, j));
    end
end
data = zeros(402, 4);
data(:, 1) = predict(:, 1);
data(:, 2) = cost(:, 1);
data(:, 3) = delivery_all(:, 1);
data(:, 4) = supply_all(:, 1);
%进行灰色关联度分析
result = huise(data);
%熵权法计算各指标的权重
[score, weights] = shangquan(data(:, 2:end));
%归一化各指标数据
data(:, 2) = guiyi(data(:, 2), 2, 0.002, 0.996); 
data(:, 3) = guiyi(data(:, 3), 2, 0.002, 0.996);
data(:, 4) = guiyi(data(:, 4), 1, 0.002, 0.996);
significance = zeros(402, 1);
for i = 1:402
    significance(i) = data(i, 2) * weights(1) + data(i, 3) * weights(2) + data(i, 4) * weights(3);
end
xlswrite('问题1.xlsx', significance, '供应商重要性', 'B2:B403');
