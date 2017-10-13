%% 主成分分析：只要输入数据矩阵 gj ，即可得到 gj 的主成分分析，注意如果 gj 不是相关系数矩阵
% 输入
% gj : 数据矩阵，gj 每行代表一组数据 （不要包含数据的索引）
% （num 通过 contr 的贡献百分比决定，键盘输入）
% 输出
% stf : 从高到低的综合得分
% ind : 综合得分对应的索引
function [stf,ind] = ZhuChengFenAnalysis(gj)
	% gj = load('?'); % 读取文件数据
	gj = zscore(gj);	% 数据标准化
	r = corrcoef(gj); % 计算相关系数矩阵
	% 下面利用相关系数阵进行主成分分析，vec1 的列为 r 的特征向量，即主成分系数
	[vec1, lamda, rate] = pcacov(r);
	f = repmat(sign(sum(vec1)), size(vec1,1), 1);
	vec2 = vec1.*f;
	contr = cumsum(rate) / sum(rate)
	num = input('num='); % num 为选取的主成分的个数
	% num = 4;
	df = gj*vec2(:,1:num); % 计算各个主成分的得分
	tf = df*rate(1:num) / 100; % 计算综合得分
	[stf,ind] = sort(tf,'descend');
	stf = stf';ind = ind';
	
	% git结果
end