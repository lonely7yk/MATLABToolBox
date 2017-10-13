%% LinearRegress: 线性回归分析，可以当 Regress 使用，添加了一些统计数据

% input
% Y : 因变量
% X : 自变量（不要忘了 1 向量）
% alpha : 显著性水平

% output
% b : 自变量系数
% bint : 自变量系数置信区间
% r : 残差
% rint : 残差置信区间
% stats : 统计数据（1. 判定系数R^2，2. F统计量观测值，3. 检验的p的值
%			 （<0.5即为合理，表现线性相关关系强），4. 误差方差的估计）
% result : 其他统计数据（1. ymean 2. yhat 3. u 回归平方和 4. eplison 残差
% 			5. delta 相对误差 6. F 7. fw1,fw2 F 上分位 8. t 9. tfw t上分位）

function [b,bint,r,rint,stats,result] = LinearRegress(Y,X,alpha)

	if nargin < 3
		alpha = 0.05;
	end
	
	%% ******************************** 可以直接复用以下代码 *********************************
	
	[b,bint,r,rint,stats] = regress(Y,X,alpha);	% 做回归分析
	q = sum(r.^2)		% 残差平方和
	result.ymean = mean(Y);		% 计算 y 的观测值的平均值
	result.yhat = X * b;		% 计算 y 的估计值
	result.u = sum((result.yhat - result.ymean).^2);	% 计算回归平方和
	result.elipson = result.yhat - Y;	% 残差
	result.delta = abs(result.elipson ./ Y);	% 相对误差
	m = 3;				% 变量个数，拟合参数的个数为 m + 1
	n = length(Y);		% 样本点的个数
	
	%% ******************************** F 检验 *********************************
	% 在 stats 中其实已经包含 F 检验，stats(2) 即为下面的 F
	result.F = result.u / m / (q / (n - m - 1));	% 计算 F 统计量的值，自由度为样本点的个数减去拟合参数的个数
	result.fw1 = finv(alpha / 2,m,n - m -1);	% 计算上 1 - alpha / 2 分位数
	result.fw2 = finv(1 - alpha/2,m,n - m -1);	% 计算上 alpha / 2 分位数
	
	%% ******************************** T 检验 *********************************
	c = diag(inv(X' * X));							% 计算 c(i,j) 的值
	result.t = b ./ sqrt(c) / sqrt(q / (n-m-1));	% 计算 t 统计量的值
	result.tfw = tinv(1 - alpha/2,n-m-1);			% 计算 t 分布的上 alpha / 2 费位数
	
	rcoplot(r,rint);
end