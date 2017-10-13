%% ARMA: ARMA 平稳时间序列预测
function [result,m] = ARMA(x,num)

	if size(x,2) ~= 1
		error('x 必须为列向量');
	end
	
	%% 对输入的序列 x 做ARMA序列预测，选取AIC最小的 p,g 作为模型阶数(可复用)
	
	% num = 3;
	myaic = zeros(4,4);
	myaic(:) = inf;
	for i = 0:3
		for j = 0:3
			if i == 0 & j == 0
				continue
			end
			m = armax(x, [i, j]);
			% myaic = aic(m);
			myaic(i+1,j+1) = aic(m);
			fprintf('p = %d, q = %d, AIC = %f\n', i, j, aic(m));
		end
	end
	% p = input('输入阶数 p = ');	% 输入模型阶数
	% q = input('输入阶数 q = ');	
	[p,g] = find(myaic == min(min(myaic))); %选取AIC最小对应的 p,q
	p = p - 1;  	% 因为数组以 1 开头，而p,q 应该以 0 开头，所以 p,q 均减一
	g = g - 1;
	fprintf(['做 ARMA(',num2str(p),',',num2str(g),') 拟合'])
	m = armax(x, [p,g])
	
	%% ******************************** 预测 *********************************
	xp = predict(m, x);
	% res = resid(m,x);
	res = x - xp;
	h = lbqtest(res);		% Ljung-Box 检验
	
	result = [];		% 返回结果
	for i = 1:num
		% 1 步预测，样本数据必须为列向量，要预测 1 个值，x 后要加一个任意数，
		% 1 步预测要用到 t - 1 步的数据
		xp = predict(m,[x;0],1);
		xhat = xp(end);
		x = [x;xhat];
		result = [result;xhat];
	end

end