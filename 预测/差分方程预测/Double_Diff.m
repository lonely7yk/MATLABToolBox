%% Double_Diff: 二阶差分方程预测模型 —— y(i,j) = alpha1 * y(i,j-2) + alpha2 * y(i,j-1) + alpha3;
% 适用于 y 并非随 x 等量增长，而是受限于前一个或几个 y ，如商品销售量预测

% input
% y0 : 训练数据矩阵，横向是年份，纵向是季度，预测横向数据，矩阵可以只有一行
% num : 预测多少年的数据

% output
% result : 预测数据矩阵

function [result] = Double_Diff(y0,num)
	
	% num = 3;
	m = size(y0,1);		% y0 行数
	n = size(y0,2);		% y0 列数
	
	% 差分方程为 y(i,j) = alpha1 * y(i,j-2) + alpha2 * y(i,j-1) + alpha3;
	y = nonzeros(y0(:,3:n)); 	% nonzeros 的作用是把矩阵 y0 的所有值变成行向量，按一列一列的顺序
	x = [nonzeros(y0(:,1:n-2)),nonzeros(y0(:,2:n-1)),ones(m * (n - 2),1)];
	alpha = x \ y;
	
	for j = n+1:n+num
		for i = 1:size(y0,1)
			y0(i,j) = alpha(1) * y0(i,j-2) + alpha(2) * y0(i,j-1) + alpha(3);
		end
	end
	
	result = y0(:,n+1:end);
end