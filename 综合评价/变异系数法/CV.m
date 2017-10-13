%% CV: 变异系数法求权重
function [weight] = CV(data)
	% input
	% data : “标准化”后的数据，m * n，m 个对象，n 个指标
	% output
	% weight : n 个指标的权值

	sigema = std(data,1,1);
	miu = mean(data,1);
	H = sigema ./ miu;
	weight = H ./ sum(H);
end