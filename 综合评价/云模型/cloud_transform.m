%% cloud_transform: 通过统计数据样本计算云模型的数字特征

% input
% y_spor : 原始数据（一个对象的数据）
% n : 云滴的数量

% output
% x : 云滴
% y : 隶属度
% Ex : 云模型的数字特征，表示期望
% En : 云模型的数字特征，表示熵
% He : 云模型的数字特征，表示超熵

function [x,y,Ex,En,He] = cloud_transform(y_spor,n)
	Ex = mean(y_spor);
	En = mean(abs(y_spor - Ex)) .* sqrt(pi ./ 2);
	He = sqrt(var(y_spor) - En.^2);

	% 通过云模型的数字特征还原更过的“云滴”
	for q = 1:n
		Enn = randn(1) .* He + En;
		x(q) = randn(1) .* Enn + Ex;
		y(q) = exp(-(x(q) - Ex).^2 ./ (2 .* Enn.^2));
    end
end