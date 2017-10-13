%% GM21: 灰色预测 GM(2,1)，适用于非单调的摆动发展或有饱和的 S 型序列

% 输入
% x0 : 原始数据（列向量）
% num : 预测多少个数

% 输出
% yuce_before : 对已知值的预测值
% yuce : 对未来值的预测
% epsilon : 残差		(<0.2一般要求 <0.1较高要求)
% delta : 相对误差
function [yuce,yuce_before,epsilon,delta] = GM21(x0,num)

	n = length(x0);
	x1 = cumsum(x0);		% 计算一次累加序列
	a_x0 = diff(x0)';	% 计算一次累减序列
	z = 0.5 * (x1(2:end) + x1(1:end - 1))';	% 计算矩阵序列
	B = [-x0(2:end)',-z,ones(n-1,1)];
	u = B \ a_x0	% 最小二乘法拟合参数
	
	x = dsolve('D2x + a1 * Dx + a2 * x = b',...
		strcat('x(0) = c1,x(',num2str(n - 1),') = c2'));	% 求边值问题符号解
	x = subs(x,{'a1','a2','b','c1','c2'},{u(1),u(2),u(3),x1(1),x1(n)});
	yuce_before = subs(x,'t',0:n+num-1);	% 求已知数据点 1 次累加序列的预测值
	yuce_before = double(yuce_before);	% 将预测值变成数值型数据
	
	display('x 的符号解为:')
	x = vpa(x,6)	% x 的符号解
	yuce_all = [yuce_before(1),diff(yuce_before)];	% 已知数据的预测值
	yuce_before = yuce_all(1:n);
	yuce = yuce_all(n+1:n+num);
	% x0_hat = round(x0_hat);		% 四舍五入
	epsilon = x0 - yuce_before;		% 残差值
	delta = abs(epsilon ./ x0);	% 相对误差	
end