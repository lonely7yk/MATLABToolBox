%% BORDA: 通过各对象多次排名的名次和来决定整合后的名次，"名次和"越高越高排名越靠后，也就是说最后的排名是从高到低的

% input
% data : 多次试验产生的分数数据(分数越高越优)，m*n的矩阵，m表示对象，n表示试验次数

% output
% place : 最终排名(m*1)，从高到低（排在前的是厉害的）

function [place] = BORDA(data)
	[m,n] = size(data);
	[~,index] = sort(data);
	xuhao_zong = [];
	for i = 1:m
		xuhao = [];
		for j = 1:n
			xuhao = [xuhao,find(index(:,j)==i)];	% 看 n 个数据 i 号对象为第几名
		end
		xuhao_zong = [xuhao_zong;xuhao];
	end

	xuhao_sum = sum(xuhao_zong,2);	% 求横向的和
	[~,place] = sort(xuhao_sum);
end
