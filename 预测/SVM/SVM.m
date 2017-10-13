%% 通过 svm 进行分类，修改代码中的 ? ，有下标的 ? 代
%% 表同一个变量，
%% SVM: 通过 SVM 来进行分类

% input
% training0 : 训练样本数据	(n * m)  n 个对象， m 个指标
% y0 : 训练样本对应的类别（这边默认为 1 和 2，如果题目有变化请在代码中修改）
% xa0 : 需要分类的样本

% output
% solution : 分类结果
% sg : 第一类编号
% sb : 第二类编号
% check : 验证结果
% err_rate : 错误率
% s : SVM 的结构体，可通过 s.SupportVectorIndices s.Alpha s.Bias s.ScaleData 查看各参数

function [solution,sg,sb,check,err_rate,s] = SVM(training0,y0,xa0)

	%% 数据处理
	% 注意这里题目类别有注明请修改diam
	class1 = 1;
	class2 = 2;
	
	gind = find(y0 == class1);	% 找到第一类的序号
	bind = find(y0 == class2);	% 找到第二类的序号	
	
	% training0 = a(?:?, ?:?);	% 找出训练样本
	training0 = training0';		% 要用 mapstd 将样本变量标准化，先要将样本转置
	[training, ps] = mapstd(training0);
	training = training';		% 标准化之后再转置回来
	group(gind) = class1;				
	group(bind) = class2;			% 构造出一列矩阵来表示样本分类结果
	group = group';
	% xa0 = a([501:569], [2:end]);	
	% xa0 = ?;					% 需要分类的样本
	xa0 = xa0';
	xa = mapstd('apply', xa0, ps);	% 以 xa0 标准化的标准标准化 xa
	xa = xa';
	% 这里可以修改 'Method' 参数， 'Kernel_Function' 参数
	% Method
	% 'SMO' -- 序列最小优化  'QP' -- 二次规划  'LS' -- 最小二乘法
	% Kernel_Function
	% 'linear' -- 线性  'quadratic' -- 二次 'polynomial' -- 三阶多项式(polyorder可改变阶数)
	% 'rbf' -- 因子为 1 的高斯径向基函数(rbf_sigma改变因子数) 'mlp' -- 重量 1 偏见 1 的 mlp (mlp_params)
	s = svmtrain(training, group, 'Method', 'SMO', 'Kernel_Function', 'quadratic');
	
	%% svm 的各个参数
	sv_index = s.SupportVectorIndices';	% 返回支持向量的标号
	beta = s.Alpha;	% 分类函数权系数
	b = s.Bias;		% 分类函数的常系数项
	% 第一行是一直样本点均值向量相反数相反数，第二行是标准差向量的倒数
	mean_and_std_trans = s.ScaleData;	
	
	%% 验证和预测
	check = svmclassify(s, training);	% 验证已知样本点
	err_rate = 1 - sum(check == group) / length(training)	% 错判率
	solution = svmclassify(s, xa);		% 对待测样本分类
	solution = solution';
	sg = find(solution == class1) % 第一类编号
	sb = find(solution == class2) % 第二类编号
end