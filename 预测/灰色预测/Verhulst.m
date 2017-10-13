%% Verhulst: 灰色预测 Verhulst 主要用来描述具有饱和状态的过程，
% 即 S 形过程，常用语人口预测、生物生长、繁殖预测及产品经济寿命等。

function [yuce,yuce_before,epsilon,delta] = Verhulst(x0,num)

	x1 = cumsum(x0);		% 计算一次累加序列
	n = length(x0);
	z = 0.5 * (x1(2:end) + x1(1:end - 1));	% 计算矩阵序列
	B = [-z',z'.^2];
	Y = x0(2:end)';
	ab_hat = B \ Y;	% 估计参数 a，b
	a = ab_hat(1)
	b = ab_hat(2)

	x = dsolve('Dx + a * x = b * x^2','x(0) = x0');	% 求解常微分方程
	x = subs(x,{'a','b','x0'},{a,b,x0(1)});		% 代入参数值
	yuce = subs(x,'t',[0:n+num-1]);		% 1 次累加序列的预测值
	yuce = double(yuce);		% 转化为数值类型
	x = vpa(x,6)		% x 的符号解

	yuce_all = [yuce(1),diff(yuce)];
	yuce_before = yuce_all(1:n);	% 原数据的预测值
	yuce = yuce_all(n+1:n+num);		% num 个预测值
	epsilon = x0 - yuce_before;			% 残差值
	delta = abs(epsilon ./ x0);			% 相对误差end
end