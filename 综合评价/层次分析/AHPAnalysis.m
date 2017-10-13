%% AHPAnalysis: 层次分析法
% 输入
% a : 第二层（准则层）的变量判断矩阵
% n1 : 第二层变量数目
% b : 第三层（措施层）的变量判断矩阵
% n2 : 第三层变量数目
% 输出
% ts : n2 种措施（措施层）对目标的权重（目标层）
% w0 : 第二层（准则层）的变量的权重
% w1 : 第三层（措施层）的变量对第二层各指标的权重
% cr : 总体的一致性比例		（小于 0.10 通过）
% cr0 : 第二层的一致性比例	
% cr1 : 第三层的一致性比例
function [ts,w0,w1,cr,cr0,cr1] = AHPAnalysis(a,n1,b,n2)

RI = [0 0 0.58 0.90 1.12 1.24 1.32 1.41 1.45];	% 平均随机一致性指标
[x,y] = eig(a);		% x : 特征向量 y : 特征值
lambda = max(diag(y));
num = find(diag(y) == lambda);
w0 = x(:,num) / sum(x(:,num));	% x(:,num) : 最大的特征值对应的特征向量
cr0 = (lambda - n1) / (n1 - 1) / RI(n1);
for i = 1:n1
	[x,y] = eig(b{i});
	lambda = max(diag(y));
	num = find(diag(y) == lambda);
	w1(:,i) = x(:,num) / sum(x(:,num));
	cr1(i) = (lambda - n2) / (n2 - 1) / RI(n1);
end
% cr1
ts = w1 * w0;
cr = cr1 * w0;
