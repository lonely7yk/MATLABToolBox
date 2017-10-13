%% 通过 svm 进行分类，修改代码中的 ? ，有下标的 ? 代
%% 表同一个变量，
clc,clear
a = load('?');
a(:,?) = []; 	% 删除与判断变量无关的变量，如病历号SVM
gind = find(a(:,1) == ?1);	% 找到第一类的序号
bind = find(a(:,1) == ?2);	% 找到第二类的序号
training0 = a(?:?, ?:?);	% 找出训练样本
training0 = training0';		% 要用 mapstd 将样本变量标准化，先要将样本转置
[training, ps] = mapstd(training0);
training = training';		% 标准化之后再转置回来
group(gind) = ?1;				
group(bind) = ?2;			% 构造出一列矩阵来表示样本分类结果
group = group';
% xa0 = a([501:569], [2:end]);	
xa0 = ?;					% 需要分类的样本
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
sv_index = s.SupportVectorIndices';	% 返回支持向量的标号
beta = s.Alpha;	% 分类函数权系数
b = s.Bias;		% 分类函数的常系数项
% 第一行是一直样本点均值向量相反数相反数，第二行是标准差向量的倒数
mean_and_std_trans = s.ScaleData;	
check = svmclassify(s, training);	% 验证已知样本点
err_rate = 1 - sum(check == group) / length(training)	% 错判率
solution = svmclassify(s, xa);		% 对待测样本分类
solution = solution';
sg = find(solution == ?1) % 第一类编号
sb = find(solution == ?2) % 第二类编号
