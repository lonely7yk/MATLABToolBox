%% 计算 R 型聚类 : 分析变量之间的相关性，调用将打印聚类结果，并画出聚类图
% 输入
% gj : 数据矩阵， 每一行代表一组数据
% num : 分类数量
% way : 聚类方法
function RJuLeiAnalysis(gj, num, way)

	if nargin < 3
		way = 'complete';
	end
	% a = textread('?') % 对相关系数矩阵 a 进行赋值
	
	% 如果相关系数矩阵没有直接给你，而是给的样本矩阵 gj ，可以
	% 通过 corrcoef(gj) 来得到相关系数，注意 corrcoef 计算
	% 的是列与列之间的相关系数矩阵
	gj = zscore(gj);
	a = corrcoef(gj);
	
	d = 1 - abs(a); % 计算距离
	d = tril(d); % 取下三角
	nd = nonzeros(d); % 取不是 0 的值
	nd = nd'; % 化成行向量
	z = linkage(nd, way) % 产生等级聚类树，并选择聚类方法
	% num = ?;  % 表示分多少类
	T = cluster(z,'maxclust',num) % 第一个参数表示生成聚类的阈值（一般为 maxclust），第二个参数表示分为多少类，y 为 n 行 1 列的矩阵（n 为指标数目）
	for i = 1:num	
		tm = find(T == i); % 求第 i 类的对象
		tm = reshape(tm,1,length(tm)); % 变成行向量，方便输出
		fprintf('第 %d 类的有 %s\n',i, int2str(tm)); % 打印分类结果
	end
	h = dendrogram(z); % 画聚类图
	set(h, 'Color', 'k', 'LineWidth', 1.3); % 设置图的线宽和颜色
end