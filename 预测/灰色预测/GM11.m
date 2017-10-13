%% GM11: 灰色预测 GM(1,1)，适用于具有较强指数规律的序列

% 输入
% x0 : 原始数据（列向量）
% num : 预测多少个数
% plus : 级比范围不合适时，做的平移默认为0
% x0 = [71.1 72.4 72.4 72.1 71.4 72 71.6]

% 输出
% yuce : 对已知值的预测值
% yuce_after : 对未来值的预测
% epsilon : 残差		(<0.2一般要求 <0.1较高要求)
% delta : 相对误差
% rho : 级比偏差值 （<0.2可以接受 <0.1较好）
function [yuce_after,yuce,epsilon,delta,rho] = GM11(x0,num,plus)
	if nargin < 3
		plus = 0;
	end

	x0 = x0 + plus;

	if size(x0,1) < size(x0,2)
% 		error('请将 x0 转换为列向量\n');
% 		return;
        x0 = x0';   % 行向量变列向量
	end
	n = length(x0);	% 原始数据的长度
	lambda = x0(1:n-1) ./ x0(2:n);	% 级比
	range = minmax(lambda');	% 级比范围
	% if range(1) < exp(-2/(n+1)) || range(2) > exp(2/(n+2))	% 本来应该这么写判断级比范围，这里我封装成了函数
	if ~JudgeJiBi(x0)
		error('级比范围不合适，请做适当平移');
	else
		disp('      ');
		disp('可用GM11建模');
	end
	x1 = cumsum(x0);	% 累加计算	
	B = [-0.5 * (x1(1:n-1) + x1(2:n)), ones(n-1,1)];
	Y = x0(2:n);
	u = B \ Y;	% 拟合参数 u(1) = a, u(2) = b
	a = u(1)
	b = u(2)
	x = dsolve('Dx + a * x = b','x(0) = x0');	% 求微分方程的符号解
	x = subs(x, {'a','b','x0'}, {u(1),u(2),x0(1)});	% 代入估计参数值和初始解
	x1 = x;
	yuce1 = subs(x, 't', [0:n+num-1]);	% 求已知数据的预测值
	y = vpa(x,6)	% 显示 6 位数字的 x 表达式
	% 由于 yuce1 是 sym 数组不能直接用 diff 差分
	% yuce = [x0(1), diff(yuce1)]	% 差分运算，还原数据

	yuce1 = double(yuce1);
	temp = diff(yuce1);

	yuce = temp(1:length(x0) - 1);
	yuce = [x0(1),yuce];

	epsilon = x0' - yuce;	% 计算残差
	delta = abs(epsilon ./ x0');
	rho = 1 - (1 - 0.5 * u(1)) / (1 + 0.5 * u(1)) * lambda';	% 级比偏差值	

	yuce = yuce - plus;		% 减去偏移量
	yuce = yuce';


	yuce_after = temp(length(x0):end);

	yuce_after = yuce_after - plus;
	yuce_after = yuce_after';

end

%% JudgeJiBi: 判断级比范围是否在 exp(-1/(n+1)) 和 exp(-1/(n+2)) 之间
% 输入
% x0 : 原始数据
% 输出
% isTure : 级比是否在规定范围内
function [isTrue] = JudgeJiBi(x0)
	isTrue = true;
	n = length(x0);
	lambda = x0(1:n-1) ./ x0(2:n);
	range = minmax(lambda');
	if range(1) < exp(-2/(n+1)) || range(2) > exp(2/(n+2))
		isTrue = false;
	end
end