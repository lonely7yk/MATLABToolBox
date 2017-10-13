%% logistic: Logistic 回归模型

% input
% X0 : 回归数据自变量	(n * m)
% Y0 : 回归数据因变量
% XE : 预测数据自变量
% pi0 : P0 = 0 时的 PI，默认为 0.25
% pi1 : P0 = 1 时的 PI，默认为 0.75

% output
% coeffs : 回归系数，顺序为 : y = coeffs(1) + coeffs(2) * x(1) + coeffs(3) * x(2) + ...
% P0 : 验证结果
% P1 : 预测结果

function [coeffs,P0,P1] = logistic(X0,Y0,XE,pi0,pi1)
	if (nargin < 5)
		if (nargin < 4)
			pi0 = 0.25;
		end
		pi1 = 0.75;
	end


	%% 数据转化和参数回归
	n = size(Y0,1);	% 回归数据组数
	for i = 1:n
		if Y0(i) == 0
			Y1(i,1) = pi0;
		else
			Y1(i,1) = pi1;
		end
	end
	X1 = ones(n,1);	% 构建常数项系数
	X = [X1,X0];
	Y = log(Y1 ./ (1 - Y1));
	coeffs = regress(Y,X);	% (m + 1) * 1

	%% 模型的验证
	for i = 1:size(X,1)
		Pai0 = exp(X(i,:) * coeffs) / (1 + exp(X(i,:) * coeffs));
		if Pai0 <= 0.5
			P1(i) = 0;
		else
			P1(i) = 1;
		end
	end


	%% 模型的预测
	XE = [ones(size(XE,1)),XE];
	for i = 1:size(XE,1)
		Pai0 = exp(XE(i,:) * coeffs) / (1 + exp(XE(i,:) * coeffs));
		if Pai0 <= 0.5
			P1(i) = 0;
		else
			P1(i) = 1;
		end
	end
end
