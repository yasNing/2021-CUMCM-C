order = xlsread('..\附件1 近5年402家供应商的相关数据.xlsx', '企业的订货量（m³）', 'B2:IH403');
supply = xlsread('..\附件1 近5年402家供应商的相关数据.xlsx', '供应商的供货量（m³）', 'B2:IH403');
delivery_week = zeros(402, 241);
supply_all = zeros(402, 1);
cost = order(:, 1);
for i = 1:402
    delivery_week(i, 1) = cost(i);
    supply_all(i) = sum(supply(i, :));
    for j = 2:241
        delivery_week(i, j) = abs(supply(i, j) - order(i, j));
    end
end
%主成分分析方法来降维
%对数据进行归一化处理
nor_delivery = zscore(delivery_week);
[coeff, scores, latent, tsquare] = pca(nor_delivery);
%求解特征值的贡献率
contribute = 100 * latent / sum(latent);
%取前38个特征，此时累计贡献率达到85%以上，得出降维后的数据
reduction = nor_delivery * coeff(:, 1:38);

