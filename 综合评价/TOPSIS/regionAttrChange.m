%% 区间型属性变换
% 输入
% region : 最优属性区间
% lb : 无法容忍下限
% ub : 无法容忍上限
% x : 区间型属性值
% 输出
% y : 变换后的属性
function y = regionAttrChange(region, lb, ub, x)
	y = (1 - (region(1) - x) ./ (region(1) - lb)) .* (x >= lb & x < region(1)) + ...
		(x >= region(1) & x <= region(2)) + ...
		(1 - (region(2) - x) ./ (region(2) - ub)) .* (x > region(2) & x <= ub);
end