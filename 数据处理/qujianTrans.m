%% qujianTrans: 区间型属性变换
% 输入
% region : 最优属性区间
% lb : 无法容忍下限
% ub : 无法容忍上限
% x : 区间型属性值
% 输出
% y : 变换后的属性
function [result] = qujianTrans(qujian,lb,ub,x)
	f = @(qujian,lb,ub,x) (1 - (qujian(1) - x) ./ (qujian(1) - lb)) .* (x >= lb & x < qujian(1)) + ...
	(x >= qujian(1) & x <= qujian(2)) + ...
	(1 - (x - qujian(2)) ./ (ub - qujian(2))) .* (x > qujian(2) & x <= ub);

	result = f(qujian,lb,ub,x);
end