clc,clear('all');
p1 = 6/14; p2 = 8/14;
% 先验概率，注意在有先验概率的时候是需要加上的，这样能减小错误率
prior = [p1;p2];	
a = [24.8 24.1 26.6 23.5 25.5 27.4
-2.0 -2.4 -3.0 -1.9 -2.1 -3.1]';
b = [22.1 21.6 22.0 22.8 22.7 21.5 22.1 21.4
-.07 -1.4 -0.8 -1.6 -1.5 -1.0 -1.2 -1.3]';
n1 = 6; n2 = 8;
train = [a;b];	% 已知的训练样本
group = [ones(n1,1); 2 * ones(n2,1)];	% 训练样本对应的类别
sample = train;		% sample 为测试样本，这里会带检验正确率

[x1,y1] = classify(sample,train,group,'linear',prior)	% 线性分类
[x2,y2] = classify(sample,train,group,'quadratic',prior)	% 二次分类
