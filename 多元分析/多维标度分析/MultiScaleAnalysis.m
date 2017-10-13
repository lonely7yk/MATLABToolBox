%% MultiScaleAnalysis: 多维标度分析
function [y,eigvals] = MultiScaleAnalysis(D,cities)
	% input
	% D : 距离矩阵（直线距离），一个对称的方阵
	% cities : 一个元胞矩阵，每个元胞表示一个坐标的名字
	% output
	% y : y(:,1) 表示多维标度后 x 的坐标， y(:,2) 表示多维标度后 y 的坐标
	% eigvals

	d = nonzeros(D)';		% 按照列顺序提出矩阵 d 中的非零元素，再化成行向量
	[y,eigvals] = cmdscale(d);		% 求经典解，这里 d 为实对称阵或 pdist 格式的行向量
	plot(y(:,1),y(:,2),'o','Color','k','LineWidth',1.5)	% 画出点的坐标
	text(y(:,1) - 18,y(:,2) + 10,cities);		% 对点进行标注
end