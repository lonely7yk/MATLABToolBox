%% threeExp_all: 批量做三次指数平滑

% input
% data : 预测数据，一列表示一组需要预测的值
% num : 需要预测的步数

% output
% yuce : 预测所得结果
% yuce_before : 预测原始序列的结果


function [yuce,yuce_before] = threeExp_zong(data,num)
	% 三个不同的指标
	vector1 = data(:,1);
	vector2 = data(:,2);
	vector3 = data(:,3);

	% 以下为预测指标
	[vector1_p,vector1_before] = threeExp(vector1,num);
	[vector2_p,vector2_before] = threeExp(vector2,num);
	[vector3_p,vector3_before] = threeExp(vector3,num);

	yuce = [vector1_p,vector2_p,vector3_p];
	yuce_before = [vector1_before,vector2_before,vector3_before];
end