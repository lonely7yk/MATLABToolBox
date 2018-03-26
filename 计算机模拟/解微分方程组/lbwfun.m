%% lbwfun: 微分方程子函数 odefile 文件并命名为 lbwfun.m
function [ydot] = lbwfun(t,y)	
	ydot = [121.793 * pi * cos(2 * pi * t);
			y(1) - 4.03 * y(2);
			0.48 * y(2) - 17.87 * y(3);
			4.85 * y(3) - 4.65 * y(4);
			2.55 * y(2) + 6.12 * y(3) + 1.95 * y(4);
			1.10 * y(2) + 6.9 * y(3) + 2.70 * y(4)];
end