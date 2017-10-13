%% minJT: 进退法求极小值区间（单谷函数）
function [minx,maxx] = minJT(f,x0,h0,eps)
	% input
	% f : 目标函数
	% x0 : 初始点
	% h0 : 初始步长
	% eps : 精度
	% output
	% minx : 区间左端点
	% maxx : 区间右端点

	format long;
	if nargin == 3
		eps = 1.0e-6;
	end

	x1 = x0;
	k = 0;
	h = h0;
	while true
		x4 = x1 + h;	% 试探步
		k = k + 1;
		f4 = subs(f,symvar(f),x4);
		f1 = subs(f,symvar(f),x1);
		if f4 < f1
			x2 = x1;
			x1 = x4;
			f2 = f1;
			f1 = f4;
			h = 2 * h;	% 加大步长
		else
			if k == 1
				h = -h;	% 反向搜索
				x2 = x4;
				f2 = f4;
			else
				x3 = x2;
				x2 = x1;
				x1 = x4;
				break;
			end
		end
	end

	minx = min(x1,x3);
	maxx = x1 + x3 - minx;
	format short
end
