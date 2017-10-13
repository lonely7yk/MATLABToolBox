%% DGM21: 灰色预测 DGM(2,1)，适用于非单调的摆动发展或有饱和的 S 型序列

% 输入
% x0 : 原始数据（列向量）
% num : 预测多少个数

% 输出
% yuce_before : 对已知值的预测值
% yuce : 对未来值的预测
% epsilon : 残差		(<0.2一般要求 <0.1较高要求)
% delta : 相对误差
function [yuce,yuce_before,epsilon,delta] = DGM21(x0,num)

	n = length(x0);
	a_x0 = diff(x0)';	% 计算一次累减序列
	B = [-x0(2:end)',ones(n-1,1)];
	u = B \ a_x0	% 最小二乘法拟合参数
	
	x = dsolve('D2x + a * Dx = b',...
		strcat('x(0) = c1,Dx(0)= c2'));	% 求边值问题符号解
	x = subs(x,{'a','b','c1','c2'},{u(1),u(2),x0(1),x0(1)});
	yuce = subs(x,'t',0:n+num-1);	% 1 次累加的预测值
	yuce = double(yuce);	% 将预测值变成数值型数据

	x = vpa(x,6)
	yuce_all = [yuce(1),diff(yuce)];	% 所有预测值
	yuce_before = yuce_all(1:n);		% 已知值的预测检验
	yuce = yuce_all(n+1:n+num);			% num 个预测值
	epsilon = x0 - yuce_before;			% 残差值
	delta = abs(epsilon ./ x0);			% 相对误差
