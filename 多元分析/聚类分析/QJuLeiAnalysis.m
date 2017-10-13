%% 在 R 型聚类的基础上进行 Q 型聚类，最终打印聚类结果，并画出聚类图（分类时可以多分几次）
% 输入
% gj : 数据矩阵， 每一行代表一组数据
% remove : 通过 R 型聚类可将去掉相似度高的分析指标的列的索引
% method : 两两对象距离的取值方式 (pdist)
% way : 聚类方法
function QJuLeiAnalysis(gj, num, remove, method, way)

	if nargin < 3
		remove = [];
		method = 'euclidean'
		way = 'single';
	elseif nargin < 4
		method = 'euclidean'
		way = 'single';
	elseif nargin < 5
		way = 'single';
	end
	
	% gj = load('?'); % 得到样本矩阵 gj
	gj(:,remove) = []; % 通过 R 型聚类可将去掉相似度高的分析指标
	gj = zscore(gj); % 数据标准化
	y = pdist(gj, method); % 求对象间的距离
	z = linkage(y, way) % 产生等级聚类树，并选择聚类方法
	% num = ?;  % 表示分多少类
	% 可以多次分不同的类数来分析不同情况
	T = cluster(z,'maxclust',num) % 第一个参数表示生成聚类的阈值（一般为 maxclust），第二个参数表示分为多少类，y 为 n 行 1 列的矩阵（n 为指标数目）
	
	for i = 1:num	
		tm = find(T == i); % 求第 i 类的对象
		tm = reshape(tm,1,length(tm)); % 变成行向量，方便输出
		fprintf('第 %d 类的有 %s\n',i, int2str(tm)); % 打印分类结果
	end
	h = dendrogram(z); % 画聚类图
	set(h, 'Color', 'k', 'LineWidth', 1.3); % 设置图的线宽和颜色
end