%% test_func: 适应度函数
function [fitness] = test_func(individual)
% 	input
% 	individual : 粒子个体
% 	output
% 	fitness : 适应度值

	x = individual(:,1);
	y = individual(:,2);
	for i = 1:size(individual,1)
		fitness(i,:) = 0.5 * (x(i) - 3)^2 + 0.2 * (y(i) - 5)^2 - 0.1;
	end
end