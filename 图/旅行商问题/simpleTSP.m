%% simpleTSP: 最简单的旅行商（TSP）求解：修改圈近似算法
%% 输入 a 为矩阵，from 为从哪个点开始出发，如果 from 不在 a 矩阵中，则先将 from 放入 a 矩阵中再运算
%% 输出 circle 为路径， long 为路径长度
function [circle,long] = simpleTSP(a,from) 	% a 为矩阵，from 为从哪个点开始出发
	L = size(a,1);

	long = inf;
	c = [];
	% 先用蒙特卡洛算法求一个较好解
	for i = 1:1000
		c0 = randperm(L);
		c0(find(c0 == from)) = [];
		c0 = [from c0 from];
		temp = 0;
		for i = 1:L
			temp = temp + a(c0(i),c0(i+1));
		end
		if temp < long
			long = temp;
			c = c0;
		end
	end


	for k = 1:L
		flag = 1;	% 判断是否修改路径的条件
		for m = 1:L-2
			for n = m:L
				if (a(c(m),c(n)) + a(c(m+1),c(n+1)) < a(c(m),c(m+1)) + a(c(n),c(n+1)))
					c(m+1:n) = c(n:-1:m+1);
					flag = 0;
				end
			end
		end
		if flag == 0
			long = 0;
			for i = 1:L
				long = long + a(c(i),c(i+1));
			end
			circle = c;
			break;
		end
	end
	
end
