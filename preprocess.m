%% 数据预处理
order = xlsread('..\附件1 近5年402家供应商的相关数据.xlsx', '企业的订货量（m³）', 'B2:IH403');
supply = xlsread('..\附件1 近5年402家供应商的相关数据.xlsx', '供应商的供货量（m³）', 'B2:IH403');
for i = 1:402
    for j = 1:240
        difference = supply(i, j) - order(i, j);
        %若供货量远小于订货量，将供货量设置为订货量的临近值
        if difference < -100
            supply(i, j) = order(i, j) + round((rand() - 0.5) * 20);
        end
    end
end
xlswrite('..\附件1 近5年402家供应商的相关数据.xlsx', supply, '供应商的供货量（m³）', 'B2:IH403');
