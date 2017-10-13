clc,clear('all');
a = [9 7 8 8 9 8 7 4 3 6 2 1 6 8 2
8 6 7 5 9 9 5 4 6 3 4 2 4 1 4
7 6 8 5 3 7 6 4 6 3 5 2 5 3 5]';
train = a(1:12,:);	% 训练样本
group = [ones(7,1);2 * ones(5,1)];	% 训练样本对应类别
sample = a(13:end,:);	% 测试样本

[x1,y1] = classify(sample,train,group,'mahalanobis')    % 马氏距离分类
[x2,y2] = classify(sample,train,group,'linear')			% 线性分类
[x3,y3] = classify(sample,train,group,'quadratic')		% 二次分类
