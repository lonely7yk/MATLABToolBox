%% Season: 季节系数法（只能预测下一个时间段的）

% input
% a : 数据矩阵，每行表示一年的数据，每列表示一个季度的数据

% output
% result : 预测结果

function [result] = Season(a)

	[m,n] = size(a);
	a_mean = mean(mean(a));		% 所有数据的算术平均值
	aj_mean = mean(a);			% 同季节的算术平均值
	bj = aj_mean / a_mean;		% 计算季节系数
	w = 1:m;
	yhat = w * sum(a,2) / sum(w);	% 预测下一年的年加权平均值，这里是求行和
	yjmean = yhat / n;			% 预测年份的季节平均值
	yjhat = yjmean * bj;		% 预测年份的季节预测值
		
	result = yjhat;
end