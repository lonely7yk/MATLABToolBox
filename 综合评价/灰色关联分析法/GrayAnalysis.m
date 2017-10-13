%% GrayAnalysis: 灰色关联分析法
% 输入
% a : 数据矩阵（一行表示一组变量）P358
% goodCol : 利益型变量所在行
% badCol : 成本型变量所在行
% rho : 分辨系数
% 输出
% gsort : 从高到低排序结果
% ind : 从高到低排序对应索引
% coeff : 灰度关联系数（指标与指标之间的关联度）
% relation : 灰度加权关联度
function [gsort, ind, coeff, relation] = GrayAnalysis(a,goodCol,badCol,rho)

	if nargin < 4
		rho = 0.5;
	end

	a = a';		% 开始代码设定是一列一组变量，为了方便后面修改了一行一组变量

	for i = goodCol	% 效益型指标标准化
		a(i,:) = (a(i,:) - min(a(i,:))) / (max(a(i,:)) - min(a(i,:)));
	end

	for i = badCol	% 成本型指标标准化
		a(i,:) = (max(a(i,:)) - a(i,:)) / (max(a(i,:)) - min(a(i,:)));
	end

	[m,n] = size(a);
	reference = max(a')';	% 参考序列，每列的最大值
	t = repmat(reference,[1,n]) - a;	% 参考序列和每一个序列的差
	mmin = min(min(t));	% 计算最小差
	mmax = max(max(t));	% 计算最大差
	% rho = 0.5;	% 分辨系数
	coeff = (mmin + rho * mmax) ./ (t + rho * mmax);	% 计算灰度关联系数
	%% 下面这一条此时用等权重，其实可以用层次分析法来设置合理权重
	relation = mean(coeff);	% 取等权重
	%%
	[gsort, ind] = sort(relation, 'descend');	% 对关联度从大到小排序

	bar(relation,0.9)
end