%% LimitProbability: 求状态转移矩阵的极限概率

% input
% p : 状态转移矩阵

% output
% p_limit : 极限概率

function [p_limit] = LimitProbability(p)
	
	a = [p' - eye(3);ones(1,3)];	% 构造方程组 ax = b 的系数矩阵
	b = [zeros(3,1);1];				% 构造方程组 ax = b 的常数项数
	p_limit = a \ b;		% 求解方程组的解
end

