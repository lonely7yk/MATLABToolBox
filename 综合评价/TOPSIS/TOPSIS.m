%% TOPSIS : 理想评价法

% 输入
% a : 数据矩阵，每一行代表一组数据
% goodCol : 效益型所在的列
% badCol : 成本型所在的列
% regionCol : 区间型所在的列
% region : 最佳区间
% lb : 无法容忍下限
% ub : 无法容忍上限
% w : 各列所占权重

% 输出
% sf : 评测从好到坏的排序
% ind : 评测对应的索引
function [sf,ind] = TOPSIS(a, badCol, regionCol, region, lb, ub, w)
	if length(w) ~= size(a,2)
		fprintf('a 和 w 的长度不同');
		return;
	end

	[m, n] = size(a);

	% xtemp = a(:,regionCol);
	% a = zscore(a);
	a(:,regionCol) = regionAttrChange(region, lb, ub, a(:,regionCol));

	% a(:,regionCol) = regionAttrChange(region, lb, ub, a(:,regionCol));
	for j = 1:n
		b(:,j) = a(:,j) ./ norm(a(:,j));	% 向量规范化，适用于计算欧式距离（如理想点或负理想点）
	end
	c = b .* repmat(w, m, 1);	% 求加权矩阵
	Cstar = max(c);	% 正理想解
	Cstar(badCol) = min(c(:,badCol));
	C0 = min(c);	% 负理想解
	C0(badCol) = max(c(:,badCol));
	for i = 1:m
		Sstar(i) = norm(c(i,:) - Cstar);	% 求到正理想解的距离
		S0(i) = norm(c(i,:) - C0);			% 求到负理想解的距离
	end
	f = S0 ./ (Sstar + S0);
	[sf,ind] = sort(f, 'descend');	% 排序结果，sf 从好到坏排序
end