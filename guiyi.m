function y = guiyi(x, type, y_min, y_max)
%实现正向或负向指标归一化，返回归一化后的数据矩阵
%x为原始数据矩阵, 一行代表一个样本, 每列对应一个指标，n个指标，m个样本
%type设定正向指标1,负向指标2
%ymin,ymax为归一化的区间端点
[n, m] = size(x);
y = zeros(n, m);
x_min = min(x);
x_max = max(x);
switch type
    case 1
        for j = 1 : m
            y(:, j) = (y_max - y_min) * (x(:, j) - x_min(j)) / (x_max(j) - x_min(j)) + y_min;
        end
    case 2
        for j = 1 : m
            y(:, j) = (y_max - y_min) * (x_max(j) - x(:,j)) / (x_max(j) - x_min(j)) + y_min;
        end
end