%% 计算每个供货商的重要性占全部的比重
significance = xlsread('问题1.xlsx', '供应商重要性', 'B2:B403');
prop = zeros(402, 1);
prop_total = zeros(402, 1);
for i = 1:402
    prop(i) = 100 * significance(i) / sum(significance);
    if i == 1
        prop_total(i) = prop(i);
    else
        prop_total(i) = prop_total(i - 1) + prop(i);
    end
end
xlswrite('问题1.xlsx', prop, '供应商重要性', 'C2:C403');
xlswrite('问题1.xlsx', prop_total, '供应商重要性', 'D2:D403');